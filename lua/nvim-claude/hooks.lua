-- Claude Code hooks integration for nvim-claude
local M = {}

-- Track hook state
M.pre_edit_commit = nil
M.stable_baseline_ref = nil  -- The stable baseline to compare all changes against
M.claude_edited_files = {}  -- Track which files Claude has edited

-- Update stable baseline after accepting changes
function M.update_stable_baseline()
  local utils = require('nvim-claude.utils')
  local persistence = require('nvim-claude.inline-diff-persistence')
  
  -- Create a new stash with current state as the new baseline
  local message = 'nvim-claude-baseline-accepted-' .. os.time()
  
  -- Create a stash object without removing changes from working directory
  local stash_cmd = 'git stash create'
  local stash_hash, err = utils.exec(stash_cmd)
  
  if not err and stash_hash and stash_hash ~= '' then
    -- Store the stash with a message
    stash_hash = stash_hash:gsub('%s+', '') -- trim whitespace
    local store_cmd = string.format('git stash store -m "%s" %s', message, stash_hash)
    utils.exec(store_cmd)
    
    -- Update our stable baseline reference
    M.stable_baseline_ref = stash_hash
    persistence.current_stash_ref = stash_hash
    
    -- Save the updated state
    persistence.save_state({ stash_ref = stash_hash })
  end
end

function M.setup()
  -- Setup persistence layer on startup
  vim.defer_fn(function()
    M.setup_persistence()
  end, 500)
  
  -- Set up autocmd for opening files
  M.setup_file_open_autocmd()
end

-- Pre-tool-use hook: Create baseline stash if we don't have one
function M.pre_tool_use_hook()
  local persistence = require 'nvim-claude.inline-diff-persistence'
  
  -- Only create a baseline if we don't have one yet
  if not M.stable_baseline_ref then
    -- Create baseline stash synchronously
    local stash_ref = persistence.create_stash('nvim-claude: baseline ' .. os.date('%Y-%m-%d %H:%M:%S'))
    if stash_ref then
      M.stable_baseline_ref = stash_ref
      persistence.current_stash_ref = stash_ref
    end
  end
  
  -- Return success to allow the tool to proceed
  return true
end

-- Post-tool-use hook: Create stash of Claude's changes and trigger diff review
function M.post_tool_use_hook()
  -- Run directly without vim.schedule for testing
  local utils = require 'nvim-claude.utils'
  local persistence = require 'nvim-claude.inline-diff-persistence'

  -- Refresh all buffers to show Claude's changes
  vim.cmd 'checktime'

  -- Check if Claude made any changes
  local git_root = utils.get_project_root()
  if not git_root then
    return
  end

  local status_cmd = string.format('cd "%s" && git status --porcelain', git_root)
  local status_result = utils.exec(status_cmd)

  if not status_result or status_result == '' then
    return
  end

  -- Get list of modified files
  local modified_files = {}
  local inline_diff = require 'nvim-claude.inline-diff'
  
  for line in status_result:gmatch '[^\n]+' do
    local file = line:match '^.M (.+)$' or line:match '^M. (.+)$' or line:match '^.. (.+)$'
    if file then
      table.insert(modified_files, file)
      -- Track that Claude edited this file
      M.claude_edited_files[file] = true
      
      -- Track this file in the diff files list immediately
      local full_path = git_root .. '/' .. file
      inline_diff.diff_files[full_path] = -1  -- Use -1 to indicate no buffer yet
    end
  end

  -- Always use the stable baseline reference for comparison
  local stash_ref = M.stable_baseline_ref or persistence.current_stash_ref
  
  -- If no baseline exists at all, create one now (shouldn't happen normally)
  if not stash_ref then
    stash_ref = persistence.create_stash('nvim-claude: baseline ' .. os.date('%Y-%m-%d %H:%M:%S'))
    M.stable_baseline_ref = stash_ref
    persistence.current_stash_ref = stash_ref
  end

  if stash_ref then
    -- Process inline diffs for currently open buffers
    local opened_inline = false

    for _, file in ipairs(modified_files) do
      local full_path = git_root .. '/' .. file

      -- Find buffer with this file
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name == full_path or buf_name:match('/' .. file:gsub('([^%w])', '%%%1') .. '$') then
            -- Show inline diff for this open buffer
            M.show_inline_diff_for_file(buf, file, git_root, stash_ref)
            opened_inline = true

            -- Switch to that buffer if it's not the current one
            if buf ~= vim.api.nvim_get_current_buf() then
              vim.api.nvim_set_current_buf(buf)
            end

            break -- Only show inline diff for first matching buffer
          end
        end
      end

      if opened_inline then
        break
      end
    end

    -- If no inline diff was shown, just notify the user
    if not opened_inline then
      vim.notify('Claude made changes. Open the modified files to see inline diffs.', vim.log.levels.INFO)
    end
  end
end

-- Helper function to show inline diff for a file
function M.show_inline_diff_for_file(buf, file, git_root, stash_ref)
  local utils = require 'nvim-claude.utils'
  local inline_diff = require 'nvim-claude.inline-diff'
  
  -- Only show inline diff if Claude edited this file
  if not M.claude_edited_files[file] then
    return false
  end
  
  -- Get baseline from git stash
  local stash_cmd = string.format('cd "%s" && git show %s:%s 2>/dev/null', git_root, stash_ref, file)
  local original_content = utils.exec(stash_cmd)
  
  if original_content then
    -- Get current content
    local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local current_content = table.concat(current_lines, '\n')
    
    -- Show inline diff
    inline_diff.show_inline_diff(buf, original_content, current_content)
    return true
  end
  
  return false
end

-- Test inline diff manually
function M.test_inline_diff()
  vim.notify('Testing inline diff manually...', vim.log.levels.INFO)

  local utils = require 'nvim-claude.utils'
  local persistence = require 'nvim-claude.inline-diff-persistence'
  local git_root = utils.get_project_root()

  if not git_root then
    vim.notify('Not in git repository', vim.log.levels.ERROR)
    return
  end

  -- Get current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(bufnr)

  if buf_name == '' then
    vim.notify('Current buffer has no file', vim.log.levels.ERROR)
    return
  end

  -- Get relative path
  local relative_path = buf_name:gsub(git_root .. '/', '')
  vim.notify('Testing inline diff for: ' .. relative_path, vim.log.levels.INFO)

  -- Get baseline content - check for updated baseline first
  local inline_diff = require 'nvim-claude.inline-diff'
  local original_content = nil

  -- Check if we have an updated baseline in memory
  vim.notify('DEBUG: Checking for baseline in buffer ' .. bufnr, vim.log.levels.INFO)
  vim.notify('DEBUG: Available baselines: ' .. vim.inspect(vim.tbl_keys(inline_diff.original_content)), vim.log.levels.INFO)

  if inline_diff.original_content[bufnr] then
    original_content = inline_diff.original_content[bufnr]
    vim.notify('Using updated baseline from memory (length: ' .. #original_content .. ')', vim.log.levels.INFO)
  elseif persistence.current_stash_ref then
    -- Try to get from stash
    local stash_cmd = string.format('cd "%s" && git show %s:%s 2>/dev/null', git_root, persistence.current_stash_ref, relative_path)
    local git_err
    original_content, git_err = utils.exec(stash_cmd)

    if git_err then
      vim.notify('Failed to get stash content: ' .. git_err, vim.log.levels.ERROR)
      return
    end
    vim.notify('Using stash baseline: ' .. persistence.current_stash_ref, vim.log.levels.INFO)
  else
    -- Fall back to HEAD
    local baseline_cmd = string.format('cd "%s" && git show HEAD:%s 2>/dev/null', git_root, relative_path)
    local git_err
    original_content, git_err = utils.exec(baseline_cmd)

    if git_err then
      vim.notify('Failed to get baseline content: ' .. git_err, vim.log.levels.ERROR)
      return
    end
    vim.notify('Using HEAD as baseline', vim.log.levels.INFO)
  end

  -- Get current content
  local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local current_content = table.concat(current_lines, '\n')

  -- Show inline diff
  inline_diff.show_inline_diff(bufnr, original_content, current_content)
end

-- Set up autocmd to check for diffs when opening files
function M.setup_file_open_autocmd()
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*",
    callback = function(args)
      local bufnr = args.buf
      local file_path = vim.api.nvim_buf_get_name(bufnr)
      
      if file_path == '' then return end
      
      local utils = require 'nvim-claude.utils'
      local git_root = utils.get_project_root()
      
      if not git_root then return end
      
      -- Get relative path
      local relative_path = file_path:gsub(git_root .. '/', '')
      
      -- Check if this file was edited by Claude
      if M.claude_edited_files[relative_path] and M.stable_baseline_ref then
        -- Show inline diff for this file
        vim.defer_fn(function()
          M.show_inline_diff_for_file(bufnr, relative_path, git_root, M.stable_baseline_ref)
        end, 50) -- Small delay to ensure buffer is fully loaded
      end
    end,
    group = vim.api.nvim_create_augroup('NvimClaudeFileOpen', { clear = true })
  })
end

-- Setup persistence and restore saved state on Neovim startup
function M.setup_persistence()
  local persistence = require 'nvim-claude.inline-diff-persistence'
  
  -- Setup persistence autocmds
  persistence.setup_autocmds()
  
  -- Try to restore any saved diffs
  local restored = persistence.restore_diffs()
  
  -- Also restore the baseline reference from persistence if it exists
  if persistence.current_stash_ref then
    M.stable_baseline_ref = persistence.current_stash_ref
    vim.notify('Restored baseline: ' .. M.stable_baseline_ref, vim.log.levels.DEBUG)
  end
  
  -- Don't create a startup baseline - only create baselines when Claude makes edits
end

-- Manual hook testing
function M.test_hooks()
  vim.notify('=== Testing nvim-claude hooks ===', vim.log.levels.INFO)
  
  local persistence = require 'nvim-claude.inline-diff-persistence'

  -- Test creating a stash
  vim.notify('1. Creating test stash...', vim.log.levels.INFO)
  local stash_ref = persistence.create_stash('nvim-claude: test stash')
  
  if stash_ref then
    persistence.current_stash_ref = stash_ref
    vim.notify('Stash created: ' .. stash_ref, vim.log.levels.INFO)
  else
    vim.notify('Failed to create stash', vim.log.levels.ERROR)
  end

  -- Simulate making a change
  vim.notify('2. Make some changes to test files now...', vim.log.levels.INFO)

  -- Test post-tool-use hook after a delay
  vim.notify('3. Will trigger post-tool-use hook in 3 seconds...', vim.log.levels.INFO)

  vim.defer_fn(function()
    M.post_tool_use_hook()
  end, 3000)

  vim.notify('=== Hook testing started - make changes now! ===', vim.log.levels.INFO)
end

-- Install Claude Code hooks
function M.install_hooks()
  local utils = require 'nvim-claude.utils'

  -- Get project root
  local project_root = utils.get_project_root()
  if not project_root then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end

  -- Create .claude directory
  local claude_dir = project_root .. '/.claude'
  if not vim.fn.isdirectory(claude_dir) then
    vim.fn.mkdir(claude_dir, 'p')
  end

  -- Create hooks configuration
  local server_name = vim.v.servername or 'NVIM'
  local pre_command = string.format(
    'nvim --headless --server %s --remote-send "<C-\\><C-N>:lua require(\'nvim-claude.hooks\').pre_tool_use_hook()<CR>" 2>/dev/null || true',
    server_name
  )
  local post_command = string.format(
    'nvim --headless --server %s --remote-send "<C-\\><C-N>:lua require(\'nvim-claude.hooks\').post_tool_use_hook()<CR>" 2>/dev/null || true',
    server_name
  )

  local hooks_config = {
    hooks = {
      PreToolUse = {
        {
          matcher = 'Edit|Write|MultiEdit', -- Only match file editing tools
          hooks = {
            {
              type = 'command',
              command = pre_command,
            },
          },
        },
      },
      PostToolUse = {
        {
          matcher = 'Edit|Write|MultiEdit', -- Only match file editing tools
          hooks = {
            {
              type = 'command',
              command = post_command,
            },
          },
        },
      },
    },
  }

  -- Write hooks configuration
  local settings_file = claude_dir .. '/settings.json'
  local success, err = utils.write_json(settings_file, hooks_config)

  if success then
    -- Add .claude to gitignore if needed
    local gitignore_path = project_root .. '/.gitignore'
    local gitignore_content = utils.read_file(gitignore_path) or ''

    if not gitignore_content:match '%.claude/' then
      local new_content = gitignore_content .. '\n# Claude Code hooks\n.claude/\n'
      utils.write_file(gitignore_path, new_content)
      vim.notify('Added .claude/ to .gitignore', vim.log.levels.INFO)
    end

    vim.notify('Claude Code hooks installed successfully', vim.log.levels.INFO)
    vim.notify('Hooks configuration written to: ' .. settings_file, vim.log.levels.INFO)
  else
    vim.notify('Failed to install hooks: ' .. (err or 'unknown error'), vim.log.levels.ERROR)
  end
end

-- Uninstall Claude Code hooks
function M.uninstall_hooks()
  local utils = require 'nvim-claude.utils'

  -- Get project root
  local project_root = utils.get_project_root()
  if not project_root then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end

  local settings_file = project_root .. '/.claude/settings.json'

  if vim.fn.filereadable(settings_file) then
    vim.fn.delete(settings_file)
    vim.notify('Claude Code hooks uninstalled', vim.log.levels.INFO)
  else
    vim.notify('No hooks configuration found', vim.log.levels.INFO)
  end
end

-- Commands for manual hook management
function M.setup_commands()
  vim.api.nvim_create_user_command('ClaudeTestHooks', function()
    M.test_hooks()
  end, {
    desc = 'Test Claude Code hooks',
  })

  vim.api.nvim_create_user_command('ClaudeTestInlineDiff', function()
    M.test_inline_diff()
  end, {
    desc = 'Test Claude inline diff manually',
  })

  vim.api.nvim_create_user_command('ClaudeTestKeymap', function()
    require('nvim-claude.inline-diff').test_keymap()
  end, {
    desc = 'Test Claude keymap functionality',
  })
  
  vim.api.nvim_create_user_command('ClaudeDebugInlineDiff', function()
    require('nvim-claude.inline-diff-debug').debug_inline_diff()
  end, {
    desc = 'Debug Claude inline diff state',
  })

  vim.api.nvim_create_user_command('ClaudeUpdateBaseline', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local current_content = table.concat(current_lines, '\n')

    local inline_diff = require 'nvim-claude.inline-diff'
    inline_diff.original_content[bufnr] = current_content

    -- Save updated state
    local persistence = require 'nvim-claude.inline-diff-persistence'
    if persistence.current_stash_ref then
      persistence.save_state({ stash_ref = persistence.current_stash_ref })
    end

    vim.notify('Baseline updated to current buffer state', vim.log.levels.INFO)
  end, {
    desc = 'Update Claude baseline to current buffer state',
  })

  vim.api.nvim_create_user_command('ClaudeTestDiff', function()
    local utils = require 'nvim-claude.utils'

    -- Check if we're in a git repository
    local git_root = utils.get_project_root()
    if not git_root then
      return
    end

    -- Check if there are any changes
    local status_cmd = string.format('cd "%s" && git status --porcelain', git_root)
    local status_result = utils.exec(status_cmd)

    if not status_result or status_result == '' then
      vim.notify('No changes to test', vim.log.levels.INFO)
      return
    end

    -- Create test stash without restoring (to avoid conflicts)
    local timestamp = os.date '%Y-%m-%d %H:%M:%S'
    local stash_msg = string.format('[claude-test] %s', timestamp)

    local stash_cmd = string.format('cd "%s" && git stash push -u -m "%s"', git_root, stash_msg)
    local stash_result, stash_err = utils.exec(stash_cmd)

    if stash_err then
      vim.notify('Failed to create test stash: ' .. stash_err, vim.log.levels.ERROR)
      return
    end

    -- Trigger diff review with the stash (no pre-edit ref for manual test)
    local diff_review = require 'nvim-claude.diff-review'
    diff_review.handle_claude_edit('stash@{0}', nil)

    -- Pop the stash to restore changes
    vim.defer_fn(function()
      local pop_cmd = string.format('cd "%s" && git stash pop --quiet', git_root)
      utils.exec(pop_cmd)
      vim.cmd 'checktime' -- Refresh buffers
    end, 100)
  end, {
    desc = 'Test Claude diff review with current changes',
  })

  vim.api.nvim_create_user_command('ClaudeInstallHooks', function()
    M.install_hooks()
  end, {
    desc = 'Install Claude Code hooks for this project',
  })

  vim.api.nvim_create_user_command('ClaudeUninstallHooks', function()
    M.uninstall_hooks()
  end, {
    desc = 'Uninstall Claude Code hooks for this project',
  })

  vim.api.nvim_create_user_command('ClaudeResetBaseline', function()
    -- Clear all baselines and force new baseline on next edit
    local inline_diff = require 'nvim-claude.inline-diff'
    local persistence = require 'nvim-claude.inline-diff-persistence'
    
    -- Clear in-memory baselines
    inline_diff.original_content = {}
    
    -- Clear stable baseline reference
    M.stable_baseline_ref = nil
    persistence.current_stash_ref = nil
    M.claude_edited_files = {}
    
    -- Clear persistence state
    persistence.clear_state()
    
    vim.notify('Baseline reset. Next edit will create a new baseline.', vim.log.levels.INFO)
  end, {
    desc = 'Reset Claude baseline for cumulative diffs',
  })
  
  vim.api.nvim_create_user_command('ClaudeAcceptAll', function()
    local inline_diff = require 'nvim-claude.inline-diff'
    inline_diff.accept_all_files()
  end, {
    desc = 'Accept all Claude diffs across all files',
  })
  
  vim.api.nvim_create_user_command('ClaudeTrackModified', function()
    -- Manually track all modified files as Claude-edited
    local utils = require 'nvim-claude.utils'
    local git_root = utils.get_project_root()
    
    if not git_root then
      vim.notify('Not in a git repository', vim.log.levels.ERROR)
      return
    end
    
    local status_cmd = string.format('cd "%s" && git status --porcelain', git_root)
    local status_result = utils.exec(status_cmd)
    
    if not status_result or status_result == '' then
      vim.notify('No modified files found', vim.log.levels.INFO)
      return
    end
    
    local count = 0
    for line in status_result:gmatch '[^\n]+' do
      local file = line:match '^.M (.+)$' or line:match '^M. (.+)$'
      if file then
        M.claude_edited_files[file] = true
        count = count + 1
      end
    end
    
    vim.notify(string.format('Tracked %d modified files as Claude-edited', count), vim.log.levels.INFO)
    
    -- Also ensure we have a baseline
    if not M.stable_baseline_ref then
      local persistence = require 'nvim-claude.inline-diff-persistence'
      local stash_list = utils.exec('git stash list | grep "nvim-claude: baseline" | head -1')
      if stash_list and stash_list ~= '' then
        local stash_ref = stash_list:match('^(stash@{%d+})')
        if stash_ref then
          M.stable_baseline_ref = stash_ref
          persistence.current_stash_ref = stash_ref
          vim.notify('Using baseline: ' .. stash_ref, vim.log.levels.INFO)
        end
      end
    end
  end, {
    desc = 'Track all modified files as Claude-edited (for debugging)',
  })
  
  vim.api.nvim_create_user_command('ClaudeDebugTracking', function()
    -- Debug command to show current tracking state
    local inline_diff = require 'nvim-claude.inline-diff'
    local persistence = require 'nvim-claude.inline-diff-persistence'
    local utils = require 'nvim-claude.utils'
    
    vim.notify('=== Claude Tracking Debug ===', vim.log.levels.INFO)
    vim.notify('Stable baseline: ' .. (M.stable_baseline_ref or 'none'), vim.log.levels.INFO)
    vim.notify('Persistence stash ref: ' .. (persistence.current_stash_ref or 'none'), vim.log.levels.INFO)
    vim.notify('Claude edited files: ' .. vim.inspect(M.claude_edited_files), vim.log.levels.INFO)
    vim.notify('Diff files: ' .. vim.inspect(vim.tbl_keys(inline_diff.diff_files)), vim.log.levels.INFO)
    vim.notify('Active diffs: ' .. vim.inspect(vim.tbl_keys(inline_diff.active_diffs)), vim.log.levels.INFO)
    
    -- Check current file
    local current_file = vim.api.nvim_buf_get_name(0)
    local git_root = utils.get_project_root()
    if git_root then
      local relative_path = current_file:gsub('^' .. vim.pesc(git_root) .. '/', '')
      vim.notify('Current file relative path: ' .. relative_path, vim.log.levels.INFO)
      vim.notify('Is tracked: ' .. tostring(M.claude_edited_files[relative_path] ~= nil), vim.log.levels.INFO)
    end
  end, {
    desc = 'Debug Claude tracking state',
  })
  
  vim.api.nvim_create_user_command('ClaudeRestoreState', function()
    -- Manually restore the state
    local persistence = require 'nvim-claude.inline-diff-persistence'
    local restored = persistence.restore_diffs()
    
    if persistence.current_stash_ref then
      M.stable_baseline_ref = persistence.current_stash_ref
    end
    
    vim.notify('Manually restored state', vim.log.levels.INFO)
  end, {
    desc = 'Manually restore Claude diff state',
  })
  
  vim.api.nvim_create_user_command('ClaudeCleanStaleTracking', function()
    local utils = require 'nvim-claude.utils'
    local persistence = require 'nvim-claude.inline-diff-persistence'
    local git_root = utils.get_project_root()
    
    if not git_root or not M.stable_baseline_ref then
      vim.notify('No git root or baseline found', vim.log.levels.ERROR)
      return
    end
    
    local cleaned_count = 0
    local files_to_remove = {}
    
    -- Check each tracked file for actual differences
    for file_path, _ in pairs(M.claude_edited_files) do
      local diff_cmd = string.format('cd "%s" && git diff %s -- "%s" 2>/dev/null', git_root, M.stable_baseline_ref, file_path)
      local diff_output = utils.exec(diff_cmd)
      
      if not diff_output or diff_output == '' then
        -- No differences, remove from tracking
        table.insert(files_to_remove, file_path)
        cleaned_count = cleaned_count + 1
      end
    end
    
    -- Remove files with no differences
    for _, file_path in ipairs(files_to_remove) do
      M.claude_edited_files[file_path] = nil
    end
    
    -- Save updated state if we have a persistence stash ref
    if persistence.current_stash_ref then
      persistence.save_state({ stash_ref = persistence.current_stash_ref })
    end
    
    vim.notify(string.format('Cleaned %d stale tracked files', cleaned_count), vim.log.levels.INFO)
  end, {
    desc = 'Clean up stale Claude file tracking',
  })

  vim.api.nvim_create_user_command('ClaudeUntrackFile', function()
    -- Remove current file from Claude tracking
    local utils = require 'nvim-claude.utils'
    local git_root = utils.get_project_root()
    
    if not git_root then
      vim.notify('Not in a git repository', vim.log.levels.ERROR)
      return
    end
    
    local file_path = vim.api.nvim_buf_get_name(0)
    local relative_path = file_path:gsub(git_root .. '/', '')
    
    if M.claude_edited_files[relative_path] then
      M.claude_edited_files[relative_path] = nil
      vim.notify('Removed ' .. relative_path .. ' from Claude tracking', vim.log.levels.INFO)
      
      -- Also close any active inline diff for this buffer
      local inline_diff = require 'nvim-claude.inline-diff'
      local bufnr = vim.api.nvim_get_current_buf()
      if inline_diff.has_active_diff(bufnr) then
        inline_diff.close_inline_diff(bufnr)
      end
    else
      vim.notify(relative_path .. ' is not in Claude tracking', vim.log.levels.INFO)
    end
  end, {
    desc = 'Remove current file from Claude edited files tracking',
  })
end

-- Cleanup old temp files (no longer cleans up commits)
function M.cleanup_old_files()
  -- Clean up old temp files
  local temp_files = {
    '/tmp/claude-pre-edit-commit',
    '/tmp/claude-baseline-commit',
    '/tmp/claude-last-snapshot',
    '/tmp/claude-hook-test.log',
  }

  for _, file in ipairs(temp_files) do
    if vim.fn.filereadable(file) == 1 then
      vim.fn.delete(file)
    end
  end
end

return M
