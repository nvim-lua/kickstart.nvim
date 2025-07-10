-- Diff review system for nvim-claude using diffview.nvim
local M = {}

-- State tracking - make it persistent across hook calls
M.current_review = M.current_review or nil

function M.setup()
  -- Set up keybindings
  M.setup_keybindings()
  
  vim.notify('Diff review system loaded (using diffview.nvim)', vim.log.levels.DEBUG)
end

-- Handle Claude edit completion
function M.handle_claude_edit(stash_ref, pre_edit_ref)
  if not stash_ref then
    vim.notify('No stash reference provided for diff review', vim.log.levels.ERROR)
    return
  end
  
  vim.notify('Processing Claude edit with stash: ' .. stash_ref, vim.log.levels.INFO)
  
  -- Get list of changed files
  local changed_files = M.get_changed_files(stash_ref)
  if not changed_files or #changed_files == 0 then
    vim.notify('No changes detected from Claude edit', vim.log.levels.INFO)
    return
  end
  
  -- Initialize review session
  M.current_review = {
    stash_ref = stash_ref,
    pre_edit_ref = pre_edit_ref,  -- Store the pre-edit commit reference
    timestamp = os.time(),
    changed_files = changed_files,
  }
  
  -- Notify user about changes
  vim.notify(string.format(
    'Claude made changes to %d file(s): %s',
    #changed_files,
    table.concat(changed_files, ', ')
  ), vim.log.levels.INFO)
  
  vim.notify('Use <leader>dd to open diffview, <leader>df for fugitive, <leader>dc to clear review', vim.log.levels.INFO)
  
  -- Automatically open diffview
  M.open_diffview()
end

-- Handle Claude stashes (only show Claude changes)
function M.handle_claude_stashes(baseline_ref)
  if not baseline_ref then
    vim.notify('No baseline reference provided for Claude stashes', vim.log.levels.ERROR)
    return
  end
  
  vim.notify('Showing Claude stashes against baseline: ' .. baseline_ref, vim.log.levels.INFO)
  
  -- Get Claude stashes
  local claude_stashes = M.get_claude_stashes()
  if not claude_stashes or #claude_stashes == 0 then
    vim.notify('No Claude stashes found', vim.log.levels.INFO)
    return
  end
  
  -- Initialize review session for Claude stashes
  M.current_review = {
    baseline_ref = baseline_ref,
    timestamp = os.time(),
    claude_stashes = claude_stashes,
    current_stash_index = 0, -- Show cumulative view by default
    is_stash_based = true
  }
  
  -- Notify user about changes
  vim.notify(string.format(
    'Found %d Claude stash(es). Use <leader>dd for cumulative view, <leader>dh to browse.',
    #claude_stashes
  ), vim.log.levels.INFO)
  
  -- Automatically open cumulative stash view
  M.open_cumulative_stash_view()
end

-- Handle cumulative diff (always show against baseline) - legacy support
function M.handle_cumulative_diff(baseline_ref)
  -- Redirect to new stash-based handler
  M.handle_claude_stashes(baseline_ref)
end

-- Get list of files changed in the stash
function M.get_changed_files(stash_ref)
  local utils = require('nvim-claude.utils')
  local cmd = string.format('git stash show %s --name-only', stash_ref)
  local result = utils.exec(cmd)
  
  if not result or result == '' then
    return {}
  end
  
  local files = {}
  for line in result:gmatch('[^\n]+') do
    if line ~= '' then
      table.insert(files, line)
    end
  end
  return files
end

-- Get list of files changed since baseline
function M.get_changed_files_since_baseline(baseline_ref)
  local utils = require('nvim-claude.utils')
  local cmd = string.format('git diff --name-only %s', baseline_ref)
  local result = utils.exec(cmd)
  
  if not result or result == '' then
    return {}
  end
  
  local files = {}
  for line in result:gmatch('[^\n]+') do
    if line ~= '' then
      table.insert(files, line)
    end
  end
  return files
end

-- Get Claude stashes (only stashes with [claude-edit] messages)
function M.get_claude_stashes()
  local utils = require('nvim-claude.utils')
  local cmd = 'git stash list --grep="claude-edit"'
  local result = utils.exec(cmd)
  
  if not result or result == '' then
    return {}
  end
  
  local stashes = {}
  for line in result:gmatch('[^\n]+') do
    if line ~= '' then
      local stash_ref = line:match('^(stash@{%d+})')
      if stash_ref then
        table.insert(stashes, {
          ref = stash_ref,
          message = line:match(': (.+)$') or line
        })
      end
    end
  end
  return stashes
end

-- Set up keybindings for diff review
function M.setup_keybindings()
  -- Review actions
  vim.keymap.set('n', '<leader>dd', M.open_diffview, { desc = 'Open Claude diff in diffview' })
  vim.keymap.set('n', '<leader>df', M.open_fugitive, { desc = 'Open Claude diff in fugitive' })
  vim.keymap.set('n', '<leader>dc', M.clear_review, { desc = 'Clear Claude review session' })
  vim.keymap.set('n', '<leader>dl', M.list_changes, { desc = 'List Claude changed files' })
  vim.keymap.set('n', '<leader>da', M.accept_changes, { desc = 'Accept all Claude changes' })
  vim.keymap.set('n', '<leader>dr', M.decline_changes, { desc = 'Decline all Claude changes' })
  
  -- Stash browsing
  vim.keymap.set('n', '<leader>dh', M.browse_claude_stashes, { desc = 'Browse Claude stash history' })
  vim.keymap.set('n', '<leader>dp', M.previous_stash, { desc = 'View previous Claude stash' })
  vim.keymap.set('n', '<leader>dn', M.next_stash, { desc = 'View next Claude stash' })
end

-- Open diffview for current review
function M.open_diffview()
  if not M.current_review then
    -- Try to recover cumulative session from baseline
    local utils = require('nvim-claude.utils')
    local baseline_ref = utils.read_file('/tmp/claude-baseline-commit')
    if baseline_ref and baseline_ref ~= '' then
      baseline_ref = baseline_ref:gsub('%s+', '')
      local changed_files = M.get_changed_files_since_baseline(baseline_ref)
      if changed_files and #changed_files > 0 then
        M.current_review = {
          baseline_ref = baseline_ref,
          timestamp = os.time(),
          changed_files = changed_files,
          is_cumulative = true
        }
        vim.notify('Recovered cumulative review session from baseline', vim.log.levels.INFO)
      end
    end
    
    if not M.current_review then
      vim.notify('No active review session', vim.log.levels.INFO)
      return
    end
  end
  
  -- Use cumulative diff if available
  if M.current_review.is_cumulative then
    M.open_cumulative_diffview()
    return
  end
  
  -- Check if diffview is available
  local ok, diffview = pcall(require, 'diffview')
  if not ok then
    vim.notify('diffview.nvim not available, falling back to fugitive', vim.log.levels.WARN)
    M.open_fugitive()
    return
  end
  
  -- Use the pre-edit reference if available
  if M.current_review.pre_edit_ref then
    local cmd = 'DiffviewOpen ' .. M.current_review.pre_edit_ref
    vim.notify('Opening diffview with pre-edit commit: ' .. cmd, vim.log.levels.INFO)
    vim.cmd(cmd)
  else
    -- Fallback to comparing stash with its parent
    vim.notify('No pre-edit commit found, falling back to stash comparison', vim.log.levels.WARN)
    local cmd = string.format('DiffviewOpen %s^..%s', M.current_review.stash_ref, M.current_review.stash_ref)
    vim.notify('Opening diffview: ' .. cmd, vim.log.levels.INFO)
    vim.cmd(cmd)
  end
end

-- Open cumulative stash view (shows all Claude changes since baseline)
function M.open_cumulative_stash_view()
  if not M.current_review then
    vim.notify('No active review session', vim.log.levels.INFO)
    return
  end
  
  -- Check if diffview is available
  local ok, diffview = pcall(require, 'diffview')
  if not ok then
    vim.notify('diffview.nvim not available', vim.log.levels.WARN)
    return
  end
  
  if M.current_review.is_stash_based and M.current_review.claude_stashes then
    -- Show cumulative diff of all Claude stashes against baseline
    local cmd = 'DiffviewOpen ' .. M.current_review.baseline_ref
    vim.notify('Opening cumulative Claude stash view: ' .. cmd, vim.log.levels.INFO)
    vim.cmd(cmd)
  else
    -- Fallback to old behavior
    local cmd = 'DiffviewOpen ' .. M.current_review.baseline_ref
    vim.notify('Opening cumulative diffview: ' .. cmd, vim.log.levels.INFO)
    vim.cmd(cmd)
  end
end

-- Open cumulative diffview (always against baseline) - legacy support
function M.open_cumulative_diffview()
  M.open_cumulative_stash_view()
end

-- Open fugitive diff (fallback)
function M.open_fugitive()
  if not M.current_review then
    vim.notify('No active review session', vim.log.levels.INFO)
    return
  end
  
  -- Use fugitive to show diff
  local cmd = 'Gdiffsplit ' .. M.current_review.stash_ref
  vim.notify('Opening fugitive: ' .. cmd, vim.log.levels.INFO)
  vim.cmd(cmd)
end

-- List changed files
function M.list_changes()
  if not M.current_review then
    vim.notify('No active review session', vim.log.levels.INFO)
    return
  end
  
  local files = M.current_review.changed_files
  if #files == 0 then
    vim.notify('No changes found', vim.log.levels.INFO)
    return
  end
  
  -- Create a telescope picker if available, otherwise just notify
  local ok, telescope = pcall(require, 'telescope.pickers')
  if ok then
    M.telescope_changed_files()
  else
    vim.notify('Changed files:', vim.log.levels.INFO)
    for i, file in ipairs(files) do
      vim.notify(string.format('  %d. %s', i, file), vim.log.levels.INFO)
    end
  end
end

-- Telescope picker for changed files
function M.telescope_changed_files()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  
  pickers.new({}, {
    prompt_title = 'Claude Changed Files',
    finder = finders.new_table({
      results = M.current_review.changed_files,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        vim.cmd('edit ' .. selection[1])
        M.open_diffview()
      end)
      return true
    end,
  }):find()
end

-- Clear review session
function M.clear_review()
  if M.current_review then
    M.current_review = nil
    
    -- Close diffview if it's open
    pcall(function()
      vim.cmd('DiffviewClose')
    end)
    
    vim.notify('Claude review session cleared', vim.log.levels.INFO)
  else
    vim.notify('No active Claude review session', vim.log.levels.INFO)
  end
end

-- Accept all Claude changes (update baseline)
function M.accept_changes()
  local utils = require('nvim-claude.utils')
  
  -- Get project root
  local git_root = utils.get_project_root()
  if not git_root then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end
  
  -- Create new baseline commit with current state
  local timestamp = os.time()
  local commit_msg = string.format('claude-baseline-%d', timestamp)
  
  -- Stage all changes
  local add_cmd = string.format('cd "%s" && git add -A', git_root)
  local add_result, add_err = utils.exec(add_cmd)
  
  if add_err then
    vim.notify('Failed to stage changes: ' .. add_err, vim.log.levels.ERROR)
    return
  end
  
  -- Create new baseline commit
  local commit_cmd = string.format('cd "%s" && git commit -m "%s" --allow-empty', git_root, commit_msg)
  local commit_result, commit_err = utils.exec(commit_cmd)
  
  if commit_err and not commit_err:match('nothing to commit') then
    vim.notify('Failed to create new baseline: ' .. commit_err, vim.log.levels.ERROR)
    return
  end
  
  -- Update baseline reference
  local baseline_file = '/tmp/claude-baseline-commit'
  utils.write_file(baseline_file, 'HEAD')
  
  -- Clear review session
  M.current_review = nil
  
  -- Close diffview
  pcall(function()
    vim.cmd('DiffviewClose')
  end)
  
  vim.notify('All Claude changes accepted! New baseline created.', vim.log.levels.INFO)
end

-- Decline all Claude changes (reset to baseline)
function M.decline_changes()
  local utils = require('nvim-claude.utils')
  
  -- Get baseline commit
  local baseline_file = '/tmp/claude-baseline-commit'
  local baseline_ref = utils.read_file(baseline_file)
  
  if not baseline_ref or baseline_ref == '' then
    vim.notify('No baseline commit found', vim.log.levels.ERROR)
    return
  end
  
  baseline_ref = baseline_ref:gsub('%s+', '')
  
  -- Get project root
  local git_root = utils.get_project_root()
  if not git_root then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end
  
  -- Reset to baseline (hard reset)
  local reset_cmd = string.format('cd "%s" && git reset --hard %s', git_root, baseline_ref)
  local reset_result, reset_err = utils.exec(reset_cmd)
  
  if reset_err then
    vim.notify('Failed to reset to baseline: ' .. reset_err, vim.log.levels.ERROR)
    return
  end
  
  -- Clear review session
  M.current_review = nil
  
  -- Close diffview
  pcall(function()
    vim.cmd('DiffviewClose')
  end)
  
  -- Refresh buffers
  vim.cmd('checktime')
  
  vim.notify('All Claude changes declined! Reset to baseline.', vim.log.levels.INFO)
end

-- Browse Claude stashes (show list)
function M.browse_claude_stashes()
  if not M.current_review or not M.current_review.is_stash_based then
    vim.notify('No Claude stash session active', vim.log.levels.INFO)
    return
  end
  
  local stashes = M.current_review.claude_stashes
  if not stashes or #stashes == 0 then
    vim.notify('No Claude stashes found', vim.log.levels.INFO)
    return
  end
  
  -- Create a telescope picker if available, otherwise just notify
  local ok, telescope = pcall(require, 'telescope.pickers')
  if ok then
    M.telescope_claude_stashes()
  else
    vim.notify('Claude stashes:', vim.log.levels.INFO)
    for i, stash in ipairs(stashes) do
      local marker = (i == M.current_review.current_stash_index) and ' [current]' or ''
      vim.notify(string.format('  %d. %s%s', i, stash.message, marker), vim.log.levels.INFO)
    end
  end
end

-- View previous Claude stash
function M.previous_stash()
  if not M.current_review or not M.current_review.is_stash_based then
    vim.notify('No Claude stash session active', vim.log.levels.INFO)
    return
  end
  
  local stashes = M.current_review.claude_stashes
  if not stashes or #stashes == 0 then
    vim.notify('No Claude stashes found', vim.log.levels.INFO)
    return
  end
  
  local current_index = M.current_review.current_stash_index or 0
  if current_index <= 1 then
    vim.notify('Already at first stash', vim.log.levels.INFO)
    return
  end
  
  M.current_review.current_stash_index = current_index - 1
  M.view_specific_stash(M.current_review.current_stash_index)
end

-- View next Claude stash
function M.next_stash()
  if not M.current_review or not M.current_review.is_stash_based then
    vim.notify('No Claude stash session active', vim.log.levels.INFO)
    return
  end
  
  local stashes = M.current_review.claude_stashes
  if not stashes or #stashes == 0 then
    vim.notify('No Claude stashes found', vim.log.levels.INFO)
    return
  end
  
  local current_index = M.current_review.current_stash_index or 0
  if current_index >= #stashes then
    vim.notify('Already at last stash', vim.log.levels.INFO)
    return
  end
  
  M.current_review.current_stash_index = current_index + 1
  M.view_specific_stash(M.current_review.current_stash_index)
end

-- View a specific stash by index
function M.view_specific_stash(index)
  if not M.current_review or not M.current_review.is_stash_based then
    vim.notify('No Claude stash session active', vim.log.levels.INFO)
    return
  end
  
  local stashes = M.current_review.claude_stashes
  if not stashes or index < 1 or index > #stashes then
    vim.notify('Invalid stash index', vim.log.levels.ERROR)
    return
  end
  
  local stash = stashes[index]
  
  -- Check if diffview is available
  local ok, diffview = pcall(require, 'diffview')
  if not ok then
    vim.notify('diffview.nvim not available', vim.log.levels.WARN)
    return
  end
  
  -- Open diffview for this specific stash
  local cmd = string.format('DiffviewOpen %s^..%s', stash.ref, stash.ref)
  vim.notify(string.format('Opening stash %d: %s', index, stash.message), vim.log.levels.INFO)
  vim.cmd(cmd)
end

-- Telescope picker for Claude stashes
function M.telescope_claude_stashes()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  
  local stashes = M.current_review.claude_stashes
  local stash_entries = {}
  
  for i, stash in ipairs(stashes) do
    table.insert(stash_entries, {
      value = i,
      display = string.format('%d. %s', i, stash.message),
      ordinal = stash.message,
    })
  end
  
  pickers.new({}, {
    prompt_title = 'Claude Stash History',
    finder = finders.new_table({
      results = stash_entries,
      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.display,
          ordinal = entry.ordinal,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        M.current_review.current_stash_index = selection.value
        M.view_specific_stash(selection.value)
      end)
      return true
    end,
  }):find()
end

return M