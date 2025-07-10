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

-- Handle cumulative diff (always show against baseline)
function M.handle_cumulative_diff(baseline_ref)
  if not baseline_ref then
    vim.notify('No baseline reference provided for cumulative diff', vim.log.levels.ERROR)
    return
  end
  
  vim.notify('Showing cumulative diff against baseline: ' .. baseline_ref, vim.log.levels.INFO)
  
  -- Get list of changed files since baseline
  local changed_files = M.get_changed_files_since_baseline(baseline_ref)
  if not changed_files or #changed_files == 0 then
    vim.notify('No changes detected since baseline', vim.log.levels.INFO)
    return
  end
  
  -- Initialize review session for cumulative diff
  M.current_review = {
    baseline_ref = baseline_ref,
    timestamp = os.time(),
    changed_files = changed_files,
    is_cumulative = true
  }
  
  -- Notify user about changes
  vim.notify(string.format(
    'Cumulative changes in %d file(s): %s',
    #changed_files,
    table.concat(changed_files, ', ')
  ), vim.log.levels.INFO)
  
  vim.notify('Use <leader>dd to reopen diff, <leader>da to accept, <leader>dr to decline', vim.log.levels.INFO)
  
  -- Automatically open diffview
  M.open_cumulative_diffview()
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

-- Set up keybindings for diff review
function M.setup_keybindings()
  -- Review actions
  vim.keymap.set('n', '<leader>dd', M.open_diffview, { desc = 'Open Claude diff in diffview' })
  vim.keymap.set('n', '<leader>df', M.open_fugitive, { desc = 'Open Claude diff in fugitive' })
  vim.keymap.set('n', '<leader>dc', M.clear_review, { desc = 'Clear Claude review session' })
  vim.keymap.set('n', '<leader>dl', M.list_changes, { desc = 'List Claude changed files' })
  vim.keymap.set('n', '<leader>da', M.accept_changes, { desc = 'Accept all Claude changes' })
  vim.keymap.set('n', '<leader>dr', M.decline_changes, { desc = 'Decline all Claude changes' })
end

-- Open diffview for current review
function M.open_diffview()
  if not M.current_review then
    -- Try to recover from last stash if no active session
    local utils = require('nvim-claude.utils')
    local stash_list = utils.exec('git stash list | head -1')
    if stash_list and stash_list:match('%[claude%-edit%]') then
      local stash_ref = stash_list:match('(stash@{%d+})')
      if stash_ref then
        local pre_edit_ref = utils.read_file('/tmp/claude-baseline-commit')
        if pre_edit_ref then
          pre_edit_ref = pre_edit_ref:gsub('%s+', '')
        end
        M.current_review = {
          stash_ref = stash_ref,
          pre_edit_ref = pre_edit_ref,
          timestamp = os.time(),
          changed_files = M.get_changed_files(stash_ref)
        }
        vim.notify('Recovered review session from latest claude-edit stash', vim.log.levels.INFO)
      end
    end
    
    if not M.current_review then
      vim.notify('No active review session', vim.log.levels.INFO)
      return
    end
  end
  
  -- Debug logging
  vim.notify('Review session exists: ' .. vim.inspect(M.current_review), vim.log.levels.DEBUG)
  
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

-- Open cumulative diffview (always against baseline)
function M.open_cumulative_diffview()
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
  
  -- Open diffview comparing baseline with current working directory
  local cmd = 'DiffviewOpen ' .. M.current_review.baseline_ref
  vim.notify('Opening cumulative diffview: ' .. cmd, vim.log.levels.INFO)
  vim.cmd(cmd)
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

return M