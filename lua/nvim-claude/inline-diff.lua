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
  
  -- Generate unified diff
  local cmd = string.format('diff -u "%s" "%s" || true', old_file, new_file)
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
    -- Track additions and deletions separately with proper line mapping
    local current_new_line = hunk.new_start - 1 -- 0-indexed, tracks position in current buffer
    local current_old_line = hunk.old_start - 1 -- 0-indexed, tracks position in old content
    local deletions = {}
    
    for _, diff_line in ipairs(hunk.lines) do
      if diff_line:match('^%+') then
        -- This is an added line - highlight it in the current buffer
        if current_new_line >= 0 and current_new_line < #buf_lines then
          vim.api.nvim_buf_set_extmark(bufnr, ns_id, current_new_line, 0, {
            line_hl_group = 'DiffAdd',
            id = 4000 + i * 1000 + current_new_line
          })
        end
        current_new_line = current_new_line + 1
        -- Don't advance old_line for additions
      elseif diff_line:match('^%-') then
        -- This is a deleted line - show as virtual text above current position
        table.insert(deletions, {
          line = current_new_line, -- Show deletion above current position
          text = diff_line:sub(2),
        })
        current_old_line = current_old_line + 1
        -- Don't advance new_line for deletions
      else
        -- Context line - advance both
        current_new_line = current_new_line + 1
        current_old_line = current_old_line + 1
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
            {'- ' .. del.text .. padding, 'DiffDelete'}
          }},
          virt_lines_above = true,
          id = 3000 + i * 100 + j
        })
      end
    end
    
    -- Add sign in gutter for hunk
    local sign_line = hunk.new_start - 1
    local sign_text = '>'
    local sign_hl = 'DiffAdd'
    
    -- If hunk has deletions, use different sign
    if #deletions > 0 then
      sign_text = '~'
      sign_hl = 'DiffChange'
    end
    
    if sign_line >= 0 and sign_line < #buf_lines then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, sign_line, 0, {
        sign_text = sign_text,
        sign_hl_group = sign_hl,
        id = 2000 + i
      })
    end
    
    -- Add subtle hunk info at end of first line
    local info_line = hunk.new_start - 1
    if info_line >= 0 and info_line < #buf_lines then
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
  
  -- Move cursor to hunk start
  vim.api.nvim_win_set_cursor(0, {hunk.old_start, 0})
  
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
  
  -- Apply the hunk changes
  M.apply_hunk_changes(bufnr, hunk)
  
  -- Mark as applied
  diff_data.applied_hunks[diff_data.current_hunk] = true
  
  -- Refresh visualization
  M.apply_diff_visualization(bufnr)
  
  vim.notify(string.format('Accepted hunk %d/%d', diff_data.current_hunk, #diff_data.hunks), vim.log.levels.INFO)
  
  -- Move to next hunk
  M.next_hunk(bufnr)
end

-- Reject current hunk
function M.reject_current_hunk(bufnr)
  local diff_data = M.active_diffs[bufnr]
  if not diff_data then return end
  
  local hunk = diff_data.hunks[diff_data.current_hunk]
  if not hunk then return end
  
  -- Revert the hunk by applying original content
  M.revert_hunk_changes(bufnr, hunk)
  
  vim.notify(string.format('Rejected hunk %d/%d', diff_data.current_hunk, #diff_data.hunks), vim.log.levels.INFO)
  
  -- Move to next hunk
  M.next_hunk(bufnr)
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
function M.close_inline_diff(bufnr)
  -- Clear highlights and virtual text
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  
  -- Remove buffer-local keymaps
  vim.keymap.del('n', ']h', { buffer = bufnr })
  vim.keymap.del('n', '[h', { buffer = bufnr })
  vim.keymap.del('n', '<leader>ia', { buffer = bufnr })
  vim.keymap.del('n', '<leader>ir', { buffer = bufnr })
  vim.keymap.del('n', '<leader>iA', { buffer = bufnr })
  vim.keymap.del('n', '<leader>iR', { buffer = bufnr })
  vim.keymap.del('n', '<leader>iq', { buffer = bufnr })
  
  -- Clean up state
  M.active_diffs[bufnr] = nil
  M.original_content[bufnr] = nil
  
  vim.notify('Inline diff closed', vim.log.levels.INFO)
end

-- Check if buffer has active inline diff
function M.has_active_diff(bufnr)
  return M.active_diffs[bufnr] ~= nil
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