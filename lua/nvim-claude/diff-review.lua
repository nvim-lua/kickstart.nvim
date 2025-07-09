-- Diff review system for nvim-claude using diffview.nvim
local M = {}

-- State tracking
M.current_review = nil

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

-- Set up keybindings for diff review
function M.setup_keybindings()
  -- Review actions
  vim.keymap.set('n', '<leader>dd', M.open_diffview, { desc = 'Open Claude diff in diffview' })
  vim.keymap.set('n', '<leader>df', M.open_fugitive, { desc = 'Open Claude diff in fugitive' })
  vim.keymap.set('n', '<leader>dc', M.clear_review, { desc = 'Clear Claude review session' })
  vim.keymap.set('n', '<leader>dl', M.list_changes, { desc = 'List Claude changed files' })
end

-- Open diffview for current review
function M.open_diffview()
  if not M.current_review then
    vim.notify('No active review session', vim.log.levels.INFO)
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

return M