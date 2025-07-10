-- Inline diff viewer for nvim-claude
-- Shows Claude's changes directly in the current buffer with accept/reject functionality

local M = {}

-- Namespace for virtual text and highlights
local ns_id = vim.api.nvim_create_namespace('nvim_claude_inline_diff')

-- State tracking
M.active_diffs = {} -- Track active inline diffs by buffer number
M.original_content = {} -- Store original buffer content

-- Initialize inline diff for a buffer
function M.show_inline_diff(bufnr, old_content, new_content)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  
  -- Store original content
  M.original_content[bufnr] = old_content
  
  -- Get the diff between old and new content
  local diff_data = M.compute_diff(old_content, new_content)
  
  if not diff_data or #diff_data.hunks == 0 then
    vim.notify('No changes to display', vim.log.levels.INFO)
    return
  end
  
  -- Store diff data for this buffer
  M.active_diffs[bufnr] = {
    hunks = diff_data.hunks,
    new_content = new_content,
    current_hunk = 1,
    applied_hunks = {}
  }
  
  -- Apply visual indicators
  M.apply_diff_visualization(bufnr)
  
  -- Set up buffer-local keymaps
  M.setup_inline_keymaps(bufnr)
  
  -- Jump to first hunk
  M.jump_to_hunk(bufnr, 1)
  
  vim.notify('Inline diff active. Use [h/]h to navigate, <leader>ia/<leader>ir to accept/reject hunks', vim.log.levels.INFO)
end

-- Compute diff between two texts
function M.compute_diff(old_text, new_text)
  local utils = require('nvim-claude.utils')
  
  -- Write texts to temp files
  local old_file = '/tmp/nvim-claude-old.txt'
  local new_file = '/tmp/nvim-claude-new.txt'
  
  utils.write_file(old_file, old_text)
  utils.write_file(new_file, new_text)
  
  -- Generate unified diff with minimal context to avoid grouping nearby changes
  local cmd = string.format('diff -U1 "%s" "%s" || true', old_file, new_file)
  local diff_output = utils.exec(cmd)
  
  -- Parse diff into hunks
  local hunks = M.parse_diff(diff_output)
  
  return {
    hunks = hunks
  }
end

-- Parse unified diff output into hunk structures
function M.parse_diff(diff_text)
  local hunks = {}
  local current_hunk = nil
  local in_hunk = false
  
  for line in diff_text:gmatch('[^\r\n]+') do
    if line:match('^@@') then
      -- New hunk header
      if current_hunk then
        table.insert(hunks, current_hunk)
      end
      
      local old_start, old_count, new_start, new_count = line:match('^@@ %-(%d+),?(%d*) %+(%d+),?(%d*) @@')
      current_hunk = {
        old_start = tonumber(old_start),
        old_count = tonumber(old_count) or 1,
        new_start = tonumber(new_start),
        new_count = tonumber(new_count) or 1,
        lines = {},
        header = line
      }
      in_hunk = true
    elseif in_hunk and (line:match('^[%+%-]') or line:match('^%s')) then
      -- Diff line
      table.insert(current_hunk.lines, line)
    end
  end
  
  -- Add last hunk
  if current_hunk then
    table.insert(hunks, current_hunk)
  end
  
  return hunks
end

-- Apply visual indicators for diff with line highlights
function M.apply_diff_visualization(bufnr)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data then return end
  
  -- Clear existing highlights
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  
  -- Get current buffer lines for reference
  local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  
  -- Apply highlights for each hunk
  for i, hunk in ipairs(diff_data.hunks) do
    
    -- Track which lines in the current buffer correspond to additions/deletions
    local additions = {}
    local deletions = {}
    
    -- Start from the beginning of the hunk and track line numbers
    local new_line_num = hunk.new_start -- 1-indexed line number in new file
    local old_line_num = hunk.old_start -- 1-indexed line number in old file
    
    -- First, detect if this hunk is a replacement (has both - and + lines)
    local has_deletions = false
    local has_additions = false
    for _, diff_line in ipairs(hunk.lines) do
      if diff_line:match('^%-') then has_deletions = true end
      if diff_line:match('^%+') then has_additions = true end
    end
    local is_replacement = has_deletions and has_additions
    
    for _, diff_line in ipairs(hunk.lines) do
      if diff_line:match('^%+') then
        -- This is an added line - it exists in the current buffer at new_line_num
        table.insert(additions, new_line_num - 1) -- Convert to 0-indexed for extmarks
        new_line_num = new_line_num + 1
        -- Don't advance old_line_num for additions
      elseif diff_line:match('^%-') then
        -- This is a deleted line - show as virtual text above current position
        -- For replacements, the deletion should appear above the addition
        local del_line = new_line_num - 1
        if is_replacement and #additions > 0 then
          -- Place deletion above the first addition
          del_line = additions[1]
        end
        table.insert(deletions, {
          line = del_line, -- 0-indexed
          text = diff_line:sub(2),
        })
        old_line_num = old_line_num + 1
        -- Don't advance new_line_num for deletions
      elseif diff_line:match('^%s') then
        -- Context line - advance both
        new_line_num = new_line_num + 1
        old_line_num = old_line_num + 1
      end
    end
    
    -- Apply highlighting for additions
    for _, line_idx in ipairs(additions) do
      if line_idx >= 0 and line_idx < #buf_lines then
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, line_idx, 0, {
          line_hl_group = 'DiffAdd',
          id = 4000 + i * 1000 + line_idx
        })
      else
        vim.notify('Line ' .. line_idx .. ' out of range (buf has ' .. #buf_lines .. ' lines)', vim.log.levels.WARN)
      end
    end
    
    -- Show deletions as virtual text above their position with full-width background
    for j, del in ipairs(deletions) do
      if del.line >= 0 and del.line <= #buf_lines then
        -- Calculate full width for the deletion line
        local text = '- ' .. del.text
        local win_width = vim.api.nvim_win_get_width(0)
        local padding = string.rep(' ', math.max(0, win_width - vim.fn.strdisplaywidth(text)))
        
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, del.line, 0, {
          virt_lines = {{
            {text .. padding, 'DiffDelete'}
          }},
          virt_lines_above = true,
          id = 3000 + i * 100 + j
        })
      end
    end
    
    -- Add sign in gutter for hunk (use first addition or deletion line)
    local sign_line = nil
    if #additions > 0 then
      sign_line = additions[1]
    elseif #deletions > 0 then
      sign_line = deletions[1].line
    else
      sign_line = hunk.new_start - 1
    end
    
    local sign_text = '>'
    local sign_hl = 'DiffAdd'
    
    -- If hunk has deletions, use different sign
    if #deletions > 0 then
      sign_text = '~'
      sign_hl = 'DiffChange'
    end
    
    if sign_line and sign_line >= 0 and sign_line < #buf_lines then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, sign_line, 0, {
        sign_text = sign_text,
        sign_hl_group = sign_hl,
        id = 2000 + i
      })
    end
    
    -- Add subtle hunk info at end of first changed line
    local info_line = sign_line
    if info_line and info_line >= 0 and info_line < #buf_lines then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, info_line, 0, {
        virt_text = {{' [Hunk ' .. i .. '/' .. #diff_data.hunks .. ']', 'Comment'}},
        virt_text_pos = 'eol',
        id = 1000 + i
      })
    end
  end
end

-- Set up buffer-local keymaps for inline diff
function M.setup_inline_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  -- Navigation
  vim.keymap.set('n', ']h', function() M.next_hunk(bufnr) end, 
    vim.tbl_extend('force', opts, { desc = 'Next Claude hunk' }))
  vim.keymap.set('n', '[h', function() M.prev_hunk(bufnr) end,
    vim.tbl_extend('force', opts, { desc = 'Previous Claude hunk' }))
  
  -- Accept/Reject
  vim.keymap.set('n', '<leader>ia', function() M.accept_current_hunk(bufnr) end,
    vim.tbl_extend('force', opts, { desc = 'Accept Claude hunk' }))
  vim.keymap.set('n', '<leader>ir', function() M.reject_current_hunk(bufnr) end,
    vim.tbl_extend('force', opts, { desc = 'Reject Claude hunk' }))
  
  -- Accept/Reject all
  vim.keymap.set('n', '<leader>iA', function() M.accept_all_hunks(bufnr) end,
    vim.tbl_extend('force', opts, { desc = 'Accept all Claude hunks' }))
  vim.keymap.set('n', '<leader>iR', function() M.reject_all_hunks(bufnr) end,
    vim.tbl_extend('force', opts, { desc = 'Reject all Claude hunks' }))
  
  -- Exit inline diff
  vim.keymap.set('n', '<leader>iq', function() M.close_inline_diff(bufnr) end,
    vim.tbl_extend('force', opts, { desc = 'Close inline diff' }))
end

-- Jump to specific hunk
function M.jump_to_hunk(bufnr, hunk_idx)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data or not diff_data.hunks[hunk_idx] then return end
  
  local hunk = diff_data.hunks[hunk_idx]
  diff_data.current_hunk = hunk_idx
  
  -- Find the first actual changed line (addition or deletion) in this hunk
  local jump_line = nil
  local new_line_num = hunk.new_start -- 1-indexed line number in new file
  
  for _, diff_line in ipairs(hunk.lines) do
    if diff_line:match('^%+') then
      -- Found an addition - jump here
      jump_line = new_line_num
      break
    elseif diff_line:match('^%-') then
      -- Found a deletion - jump here
      jump_line = new_line_num  
      break
    elseif diff_line:match('^%s') then
      -- Context line - advance
      new_line_num = new_line_num + 1
    end
  end
  
  -- Fallback to hunk start if no changes found
  if not jump_line then
    jump_line = hunk.new_start
  end
  
  -- Move cursor to the actual changed line
  vim.api.nvim_win_set_cursor(0, {jump_line, 0})
  
  -- Update status
  vim.notify(string.format('Hunk %d/%d', hunk_idx, #diff_data.hunks), vim.log.levels.INFO)
end

-- Navigate to next hunk
function M.next_hunk(bufnr)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data then return end
  
  local next_idx = diff_data.current_hunk + 1
  if next_idx > #diff_data.hunks then
    next_idx = 1
  end
  
  M.jump_to_hunk(bufnr, next_idx)
end

-- Navigate to previous hunk
function M.prev_hunk(bufnr)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data then return end
  
  local prev_idx = diff_data.current_hunk - 1
  if prev_idx < 1 then
    prev_idx = #diff_data.hunks
  end
  
  M.jump_to_hunk(bufnr, prev_idx)
end

-- Accept current hunk
function M.accept_current_hunk(bufnr)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data then return end
  
  local hunk = diff_data.hunks[diff_data.current_hunk]
  if not hunk then return end
  
  -- Update the baseline to include this accepted change
  M.update_baseline_after_accept(bufnr, hunk)
  
  -- Mark as applied (the changes are already in the buffer)
  diff_data.applied_hunks[diff_data.current_hunk] = true
  
  -- Remove this hunk from the diff data since it's accepted
  table.remove(diff_data.hunks, diff_data.current_hunk)
  
  -- Adjust current hunk index
  if diff_data.current_hunk > #diff_data.hunks then
    diff_data.current_hunk = math.max(1, #diff_data.hunks)
  end
  
  vim.notify(string.format('Accepted hunk - %d hunks remaining', #diff_data.hunks), vim.log.levels.INFO)
  
  if #diff_data.hunks == 0 then
    -- No more hunks to review
    vim.notify('All hunks processed! Closing inline diff.', vim.log.levels.INFO)
    M.close_inline_diff(bufnr, true)  -- Keep baseline for future diffs
  else
    -- Refresh visualization and move to current hunk
    M.apply_diff_visualization(bufnr)
    M.jump_to_hunk(bufnr, diff_data.current_hunk)
  end
end

-- Reject current hunk
function M.reject_current_hunk(bufnr)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data then return end
  
  local hunk = diff_data.hunks[diff_data.current_hunk]
  if not hunk then return end
  
  -- Revert the hunk by applying original content
  M.revert_hunk_changes(bufnr, hunk)
  
  -- Create a new baseline commit with the rejected changes reverted
  local utils = require('nvim-claude.utils')
  local git_root = utils.get_project_root()
  
  if git_root then
    -- Save the buffer to ensure changes are on disk
    vim.api.nvim_buf_call(bufnr, function()
      if vim.bo.modified then
        vim.cmd('write')
        vim.notify('Buffer saved', vim.log.levels.INFO)
      else
        vim.notify('Buffer already saved', vim.log.levels.INFO)
      end
    end)
    
    -- Stage only the current file (now with hunk reverted)
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    local relative_path = file_path:gsub('^' .. git_root .. '/', '')
    
    -- Create a new baseline commit with only this file
    local timestamp = os.time()
    local commit_msg = string.format('claude-baseline-%d (rejected changes)', timestamp)
    
    -- Use git commit with only the specific file
    local commit_cmd = string.format('cd "%s" && git add "%s" && git commit -m "%s" -- "%s"', 
      git_root, relative_path, commit_msg, relative_path)
    local commit_result, commit_err = utils.exec(commit_cmd)
    
    vim.notify('Commit command: ' .. commit_cmd, vim.log.levels.DEBUG)
    vim.notify('Commit result: ' .. (commit_result or 'nil'), vim.log.levels.DEBUG)
    
    if commit_result and (commit_result:match('1 file changed') or commit_result:match('create mode') or commit_result:match('nothing to commit')) then
      -- Get the new commit hash
      local hash_cmd = string.format('cd "%s" && git rev-parse HEAD', git_root)
      local commit_hash, hash_err = utils.exec(hash_cmd)
      
      if not hash_err and commit_hash then
        commit_hash = commit_hash:gsub('%s+', '')
        -- Update the baseline file
        utils.write_file('/tmp/claude-baseline-commit', commit_hash)
        
        -- Update in-memory baseline
        local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local current_content = table.concat(current_lines, '\n')
        M.original_content[bufnr] = current_content
        
        if commit_result:match('nothing to commit') then
          vim.notify('No changes to commit after rejection, baseline updated', vim.log.levels.INFO)
        else
          vim.notify('Baseline commit created after rejection: ' .. commit_hash:sub(1, 7), vim.log.levels.INFO)
        end
      else
        vim.notify('Failed to get commit hash: ' .. (hash_err or 'unknown'), vim.log.levels.ERROR)
      end
    else
      vim.notify('Failed to create baseline commit for rejection', vim.log.levels.ERROR)
      if commit_err then
        vim.notify('Error: ' .. commit_err, vim.log.levels.ERROR)
      end
    end
  end
  
  -- Remove this hunk from the diff data since it's rejected
  table.remove(diff_data.hunks, diff_data.current_hunk)
  
  -- Adjust current hunk index
  if diff_data.current_hunk > #diff_data.hunks then
    diff_data.current_hunk = math.max(1, #diff_data.hunks)
  end
  
  vim.notify(string.format('Rejected hunk - %d hunks remaining', #diff_data.hunks), vim.log.levels.INFO)
  
  if #diff_data.hunks == 0 then
    -- No more hunks to review
    vim.notify('All hunks processed! Closing inline diff.', vim.log.levels.INFO)
    M.close_inline_diff(bufnr, true)  -- Keep baseline after rejection too
  else
    -- Refresh visualization and move to current hunk
    M.apply_diff_visualization(bufnr)
    M.jump_to_hunk(bufnr, diff_data.current_hunk)
  end
end

-- Revert hunk changes (restore original content)
function M.revert_hunk_changes(bufnr, hunk)
  -- Get current buffer lines
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local original_content = M.original_content[bufnr]
  
  if not original_content then
    vim.notify('No original content available for rejection', vim.log.levels.ERROR)
    return
  end
  
  -- Split original content into lines
  local original_lines = vim.split(original_content, '\n')
  
  -- Build new lines by reverting this hunk
  local new_lines = {}
  local buffer_line = 1
  local applied = false
  
  while buffer_line <= #lines do
    if buffer_line >= hunk.new_start and buffer_line < hunk.new_start + hunk.new_count and not applied then
      -- Revert this section by using original lines
      local orig_start = hunk.old_start
      local orig_end = hunk.old_start + hunk.old_count - 1
      
      for orig_line = orig_start, orig_end do
        if orig_line <= #original_lines then
          table.insert(new_lines, original_lines[orig_line])
        end
      end
      
      -- Skip the modified lines in current buffer
      buffer_line = hunk.new_start + hunk.new_count
      applied = true
    else
      -- Copy unchanged line
      if buffer_line <= #lines then
        table.insert(new_lines, lines[buffer_line])
      end
      buffer_line = buffer_line + 1
    end
  end
  
  -- Update buffer
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
end

-- Apply hunk changes to buffer
function M.apply_hunk_changes(bufnr, hunk)
  -- Get current buffer lines
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  
  -- Build new lines with hunk applied
  local new_lines = {}
  local buffer_line = 1
  local hunk_line = 1
  local applied = false
  
  while buffer_line <= #lines do
    if buffer_line == hunk.old_start and not applied then
      -- Apply hunk here
      for _, diff_line in ipairs(hunk.lines) do
        if diff_line:match('^%+') then
          -- Add new line
          table.insert(new_lines, diff_line:sub(2))
        elseif diff_line:match('^%-') then
          -- Skip deleted line
          buffer_line = buffer_line + 1
        else
          -- Keep context line
          table.insert(new_lines, lines[buffer_line])
          buffer_line = buffer_line + 1
        end
      end
      applied = true
    else
      -- Copy unchanged line
      if buffer_line <= #lines then
        table.insert(new_lines, lines[buffer_line])
      end
      buffer_line = buffer_line + 1
    end
  end
  
  -- Update buffer
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
end

-- Accept all hunks
function M.accept_all_hunks(bufnr)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data then return end
  
  -- Replace buffer with new content
  local new_lines = vim.split(diff_data.new_content, '\n')
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
  
  vim.notify('Accepted all Claude changes', vim.log.levels.INFO)
  
  -- Close inline diff
  M.close_inline_diff(bufnr)
end

-- Reject all hunks
function M.reject_all_hunks(bufnr)
  vim.notify('Rejected all Claude changes', vim.log.levels.INFO)
  
  -- Close inline diff
  M.close_inline_diff(bufnr)
end

-- Close inline diff mode
function M.close_inline_diff(bufnr, keep_baseline)
  -- Clear highlights and virtual text
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  
  -- Remove buffer-local keymaps
  pcall(vim.keymap.del, 'n', ']h', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '[h', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<leader>ia', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<leader>ir', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<leader>iA', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<leader>iR', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<leader>iq', { buffer = bufnr })
  
  -- Clean up state
  M.active_diffs[bufnr] = nil
  
  -- Only clear baseline if not explicitly told to keep it
  if not keep_baseline then
    M.original_content[bufnr] = nil
  end
  
  vim.notify('Inline diff closed', vim.log.levels.INFO)
end

-- Check if buffer has active inline diff
function M.has_active_diff(bufnr)
  return M.active_diffs[bufnr] ~= nil
end

-- Update baseline content after accepting a hunk
function M.update_baseline_after_accept(bufnr, hunk)
  local utils = require('nvim-claude.utils')
  local git_root = utils.get_project_root()
  
  if not git_root then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end
  
  -- Save the buffer to ensure changes are on disk
  vim.api.nvim_buf_call(bufnr, function()
    if vim.bo.modified then
      vim.cmd('write')
      vim.notify('Buffer saved', vim.log.levels.INFO)
    else
      vim.notify('Buffer already saved', vim.log.levels.INFO)
    end
  end)
  
  -- Stage only the current file
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local relative_path = file_path:gsub('^' .. git_root .. '/', '')
  
  -- Create a new baseline commit with only this file
  local timestamp = os.time()
  local commit_msg = string.format('claude-baseline-%d (accepted changes)', timestamp)
  
  -- Use git commit with only the specific file
  local commit_cmd = string.format('cd "%s" && git add "%s" && git commit -m "%s" -- "%s"', 
    git_root, relative_path, commit_msg, relative_path)
  local commit_result, commit_err = utils.exec(commit_cmd)
  
  vim.notify('Commit command: ' .. commit_cmd, vim.log.levels.INFO)
  vim.notify('Commit result: ' .. (commit_result or 'nil'), vim.log.levels.INFO)
  
  if commit_result and (commit_result:match('1 file changed') or commit_result:match('create mode') or commit_result:match('nothing to commit')) then
    -- Commit was successful or there was nothing to commit (file already at desired state)
    local hash_cmd = string.format('cd "%s" && git rev-parse HEAD', git_root)
    local commit_hash, hash_err = utils.exec(hash_cmd)
    
    if not hash_err and commit_hash then
      commit_hash = commit_hash:gsub('%s+', '')
      -- Update the baseline file
      utils.write_file('/tmp/claude-baseline-commit', commit_hash)
      
      -- Update in-memory baseline
      local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local current_content = table.concat(current_lines, '\n')
      M.original_content[bufnr] = current_content
      
      if commit_result:match('nothing to commit') then
        vim.notify('No changes to commit, baseline updated to current state', vim.log.levels.INFO)
      else
        vim.notify('Baseline commit created: ' .. commit_hash:sub(1, 7), vim.log.levels.INFO)
      end
    else
      vim.notify('Failed to get commit hash: ' .. (hash_err or 'unknown'), vim.log.levels.ERROR)
    end
  else
    vim.notify('Failed to create baseline commit', vim.log.levels.ERROR)
    if commit_err then
      vim.notify('Error: ' .. commit_err, vim.log.levels.ERROR)
    end
  end
end

-- Test keymap functionality
function M.test_keymap()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.notify('Testing keymap for buffer: ' .. bufnr, vim.log.levels.INFO)
  vim.notify('Available diff data: ' .. vim.inspect(vim.tbl_keys(M.active_diffs)), vim.log.levels.INFO)
  
  if M.active_diffs[bufnr] then
    vim.notify('Diff data found! Calling reject function...', vim.log.levels.INFO)
    M.reject_current_hunk(bufnr)
  else
    vim.notify('No diff data for this buffer', vim.log.levels.ERROR)
  end
end

return M