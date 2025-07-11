-- Persistence layer for inline diffs
-- Manages saving/loading diff state across neovim sessions without polluting git history

local M = {}
local utils = require('nvim-claude.utils')

-- State file location
M.state_file = vim.fn.stdpath('data') .. '/nvim-claude-inline-diff-state.json'

-- Save current diff state
function M.save_state(diff_data)
  -- Structure:
  -- {
  --   version: 1,
  --   timestamp: <unix_timestamp>,
  --   stash_ref: "stash@{0}",
  --   files: {
  --     "/path/to/file": {
  --       original_content: "...",
  --       hunks: [...],
  --       applied_hunks: {...}
  --     }
  --   }
  -- }
  
  local hooks = require('nvim-claude.hooks')
  
  local state = {
    version = 1,
    timestamp = os.time(),
    stash_ref = diff_data.stash_ref,
    claude_edited_files = hooks.claude_edited_files or {},
    files = {}
  }
  
  -- Collect state from all buffers with active diffs
  local inline_diff = require('nvim-claude.inline-diff')
  for file_path, bufnr in pairs(inline_diff.diff_files) do
    if inline_diff.active_diffs[bufnr] then
      local diff = inline_diff.active_diffs[bufnr]
      state.files[file_path] = {
        original_content = inline_diff.original_content[bufnr],
        hunks = diff.hunks,
        applied_hunks = diff.applied_hunks or {},
        new_content = diff.new_content
      }
    end
  end
  
  -- Save to file
  local success, err = utils.write_json(M.state_file, state)
  if not success then
    vim.notify('Failed to save inline diff state: ' .. err, vim.log.levels.ERROR)
    return false
  end
  
  return true
end

-- Load saved diff state
function M.load_state()
  if not utils.file_exists(M.state_file) then
    return nil
  end
  
  local state, err = utils.read_json(M.state_file)
  if not state then
    vim.notify('Failed to load inline diff state: ' .. err, vim.log.levels.ERROR)
    return nil
  end
  
  -- Validate version
  if state.version ~= 1 then
    vim.notify('Incompatible inline diff state version', vim.log.levels.WARN)
    return nil
  end
  
  -- Check if stash still exists
  if state.stash_ref then
    local cmd = string.format('git stash list | grep -q "%s"', state.stash_ref:gsub("{", "\\{"):gsub("}", "\\}"))
    local result = os.execute(cmd)
    if result ~= 0 then
      vim.notify('Saved stash no longer exists: ' .. state.stash_ref, vim.log.levels.WARN)
      M.clear_state()
      return nil
    end
  end
  
  return state
end

-- Clear saved state
function M.clear_state()
  if utils.file_exists(M.state_file) then
    os.remove(M.state_file)
  end
end

-- Restore diffs from saved state
function M.restore_diffs()
  local state = M.load_state()
  if not state then
    return false
  end
  
  local inline_diff = require('nvim-claude.inline-diff')
  local restored_count = 0
  
  -- Restore diffs for each file
  for file_path, file_state in pairs(state.files) do
    -- Check if file exists and hasn't changed since the diff was created
    if utils.file_exists(file_path) then
      -- Read current content
      local current_content = utils.read_file(file_path)
      
      -- Check if the file matches what we expect (either original or with applied changes)
      -- This handles the case where some hunks were accepted
      if current_content then
        -- Find or create buffer for this file
        local bufnr = vim.fn.bufnr(file_path)
        if bufnr == -1 then
          -- File not loaded, we'll restore when it's opened
          -- Store in a pending restores table
          M.pending_restores = M.pending_restores or {}
          M.pending_restores[file_path] = file_state
        else
          -- Restore the diff visualization
          inline_diff.original_content[bufnr] = file_state.original_content
          inline_diff.diff_files[file_path] = bufnr
          inline_diff.active_diffs[bufnr] = {
            hunks = file_state.hunks,
            new_content = file_state.new_content,
            current_hunk = 1,
            applied_hunks = file_state.applied_hunks or {}
          }
          
          -- Apply visualization
          inline_diff.apply_diff_visualization(bufnr)
          inline_diff.setup_inline_keymaps(bufnr)
          
          restored_count = restored_count + 1
        end
      end
    end
  end
  
  if restored_count > 0 then
    -- Silent restore - no notification
  end
  
  -- Store the stash reference for future operations
  M.current_stash_ref = state.stash_ref
  
  -- Restore Claude edited files tracking
  if state.claude_edited_files then
    local hooks = require('nvim-claude.hooks')
    hooks.claude_edited_files = state.claude_edited_files
  end
  
  return true
end

-- Check for pending restores when a buffer is loaded
function M.check_pending_restore(bufnr)
  if not M.pending_restores then
    return
  end
  
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local file_state = M.pending_restores[file_path]
  
  if file_state then
    local inline_diff = require('nvim-claude.inline-diff')
    
    -- Restore the diff for this buffer
    inline_diff.original_content[bufnr] = file_state.original_content
    inline_diff.diff_files[file_path] = bufnr
    inline_diff.active_diffs[bufnr] = {
      hunks = file_state.hunks,
      new_content = file_state.new_content,
      current_hunk = 1,
      applied_hunks = file_state.applied_hunks or {}
    }
    
    -- Apply visualization
    inline_diff.apply_diff_visualization(bufnr)
    inline_diff.setup_inline_keymaps(bufnr)
    
    -- Remove from pending
    M.pending_restores[file_path] = nil
    
    -- Silent restore - no notification
  end
end

-- Create a stash of current changes (instead of baseline commit)
function M.create_stash(message)
  local utils = require('nvim-claude.utils')
  message = message or 'nvim-claude: pre-edit state'
  
  -- Create a stash object without removing changes from working directory
  local stash_cmd = 'git stash create'
  local stash_hash, err = utils.exec(stash_cmd)
  
  if not err and stash_hash and stash_hash ~= '' then
    -- Store the stash with a message
    stash_hash = stash_hash:gsub('%s+', '') -- trim whitespace
    local store_cmd = string.format('git stash store -m "%s" %s', message, stash_hash)
    utils.exec(store_cmd)
    
    -- Get the stash reference
    local stash_list = utils.exec('git stash list -n 1')
    if stash_list then
      local stash_ref = stash_list:match('^(stash@{%d+})')
      return stash_ref
    end
  end
  
  return nil
end

-- Setup autocmds for persistence
function M.setup_autocmds()
  local group = vim.api.nvim_create_augroup('NvimClaudeInlineDiffPersistence', { clear = true })
  
  -- Save state before exiting vim
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = function()
      local inline_diff = require('nvim-claude.inline-diff')
      -- Only save if there are active diffs
      local has_active_diffs = false
      for _, diff in pairs(inline_diff.active_diffs) do
        if diff then
          has_active_diffs = true
          break
        end
      end
      
      if has_active_diffs and M.current_stash_ref then
        M.save_state({ stash_ref = M.current_stash_ref })
      else
        -- Save just the Claude edited files tracking even if no active diffs
        local hooks = require('nvim-claude.hooks')
        if hooks.claude_edited_files and next(hooks.claude_edited_files) then
          M.save_state({ stash_ref = M.current_stash_ref or '' })
        end
      end
    end
  })
  
  -- Check for pending restores when buffers are loaded
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = group,
    callback = function(ev)
      M.check_pending_restore(ev.buf)
    end
  })
  
  -- Auto-restore on VimEnter
  vim.api.nvim_create_autocmd('VimEnter', {
    group = group,
    once = true,
    callback = function()
      -- Delay slightly to ensure everything is loaded
      vim.defer_fn(function()
        M.restore_diffs()
      end, 100)
    end
  })
end

return M