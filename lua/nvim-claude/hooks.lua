-- Claude Code hooks integration for nvim-claude
local M = {}

-- Track hook state
M.pre_edit_commit = nil

function M.setup()
  vim.notify('Hooks module loaded', vim.log.levels.DEBUG)
  
  -- Auto-cleanup old Claude commits on startup
  vim.defer_fn(function()
    M.cleanup_old_commits()
  end, 200)
end

-- Pre-tool-use hook: Create baseline commit only if one doesn't exist
function M.pre_tool_use_hook()
  vim.notify('Pre-hook called', vim.log.levels.INFO)
  
  -- Debug log
  local debug_msg = string.format('Pre-hook executing at %s', os.date('%Y-%m-%d %H:%M:%S'))
  vim.fn.writefile({debug_msg}, '/tmp/claude-pre-hook-debug.log', 'a')
  
  local utils = require('nvim-claude.utils')
  
  -- Check if we're in a git repository
  local git_root = utils.get_project_root()
  if not git_root then
    vim.notify('Not in a git repository', vim.log.levels.WARN)
    return
  end
  
  -- Check if we already have a baseline commit
  local baseline_file = '/tmp/claude-baseline-commit'
  local existing_baseline = utils.read_file(baseline_file)
  
  if existing_baseline and existing_baseline ~= '' then
    existing_baseline = existing_baseline:gsub('%s+', '')
    -- Verify the baseline commit still exists
    local check_cmd = string.format('cd "%s" && git rev-parse --verify %s', git_root, existing_baseline)
    local check_result, check_err = utils.exec(check_cmd)
    
    if not check_err then
      vim.notify('Using existing baseline commit: ' .. existing_baseline, vim.log.levels.INFO)
      return
    end
  end
  
  -- Create new baseline commit
  local timestamp = os.time()
  local commit_msg = string.format('claude-baseline-%d', timestamp)
  
  -- Stage all current changes (including untracked files)
  local add_cmd = string.format('cd "%s" && git add -A', git_root)
  local add_result, add_err = utils.exec(add_cmd)
  
  if add_err then
    vim.notify('Failed to stage changes: ' .. add_err, vim.log.levels.ERROR)
    return
  end
  
  -- Create a temporary commit
  local commit_cmd = string.format('cd "%s" && git commit -m "%s" --allow-empty', git_root, commit_msg)
  local commit_result, commit_err = utils.exec(commit_cmd)
  
  if commit_err and not commit_err:match('nothing to commit') then
    vim.notify('Failed to create baseline commit: ' .. commit_err, vim.log.levels.ERROR)
    return
  end
  
  -- Store the actual commit hash instead of 'HEAD'
  local hash_cmd = string.format('cd "%s" && git rev-parse HEAD', git_root)
  local commit_hash, hash_err = utils.exec(hash_cmd)
  
  if not hash_err and commit_hash and commit_hash ~= '' then
    commit_hash = commit_hash:gsub('%s+', '')
    M.baseline_commit = commit_hash
    utils.write_file(baseline_file, commit_hash)
  else
    M.baseline_commit = 'HEAD'
    utils.write_file(baseline_file, 'HEAD')
  end
  
  vim.notify('New baseline commit created: ' .. commit_msg, vim.log.levels.INFO)
end

-- Post-tool-use hook: Create stash of Claude's changes and trigger diff review
function M.post_tool_use_hook()
  vim.notify('Post-hook called', vim.log.levels.INFO)
  
  -- Debug log
  local debug_msg = string.format('Post-hook executing at %s', os.date('%Y-%m-%d %H:%M:%S'))
  vim.fn.writefile({debug_msg}, '/tmp/claude-post-hook-debug.log', 'a')
  
  vim.notify('Post-tool-use hook triggered', vim.log.levels.INFO)
  
  -- Use vim.schedule to ensure we're in the main thread
  vim.schedule(function()
    local utils = require('nvim-claude.utils')
    
    -- Refresh all buffers to show Claude's changes
    vim.cmd('checktime')
    
    -- Check if Claude made any changes
    local git_root = utils.get_project_root()
    if not git_root then
      vim.notify('Not in a git repository', vim.log.levels.WARN)
      return
    end
    
    local status_cmd = string.format('cd "%s" && git status --porcelain', git_root)
    local status_result = utils.exec(status_cmd)
    
    if not status_result or status_result == '' then
      vim.notify('No changes detected from Claude', vim.log.levels.INFO)
      return
    end
    
    -- Create a stash of Claude's changes (but keep them in working directory)
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    local stash_msg = string.format('[claude-edit] %s', timestamp)
    
    -- Use git stash create to create stash without removing changes
    local stash_cmd = string.format('cd "%s" && git stash create -u', git_root)
    local stash_hash, stash_err = utils.exec(stash_cmd)
    
    if not stash_err and stash_hash and stash_hash ~= '' then
      -- Store the stash with a message
      stash_hash = stash_hash:gsub('%s+', '') -- trim whitespace
      local store_cmd = string.format('cd "%s" && git stash store -m "%s" %s', git_root, stash_msg, stash_hash)
      utils.exec(store_cmd)
      
      -- Get the baseline commit reference
      local baseline_ref = utils.read_file('/tmp/claude-baseline-commit')
      if baseline_ref then
        baseline_ref = baseline_ref:gsub('%s+', '') -- trim whitespace
      end
      
      -- Trigger diff review - show Claude stashes against baseline
      local ok, diff_review = pcall(require, 'nvim-claude.diff-review')
      if ok then
        diff_review.handle_claude_stashes(baseline_ref)
      else
        vim.notify('Diff review module not available: ' .. tostring(diff_review), vim.log.levels.ERROR)
      end
    else
      vim.notify('Failed to create stash of Claude changes', vim.log.levels.ERROR)
    end
  end)
end

-- Manual hook testing
function M.test_hooks()
  vim.notify('=== Testing nvim-claude hooks ===', vim.log.levels.INFO)
  
  -- Test pre-tool-use hook
  vim.notify('1. Testing pre-tool-use hook (creating snapshot)...', vim.log.levels.INFO)
  M.pre_tool_use_hook()
  
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
  local utils = require('nvim-claude.utils')
  
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
  local pre_command = string.format('nvim --headless --server %s --remote-send "<C-\\><C-N>:lua require(\'nvim-claude.hooks\').pre_tool_use_hook()<CR>" 2>/dev/null || true', server_name)
  local post_command = string.format('nvim --headless --server %s --remote-send "<C-\\><C-N>:lua require(\'nvim-claude.hooks\').post_tool_use_hook()<CR>" 2>/dev/null || true', server_name)
  
  local hooks_config = {
    hooks = {
      PreToolUse = {
        {
          matcher = ".*",  -- Match all tools
          hooks = {
            {
              type = "command",
              command = pre_command
            }
          }
        }
      },
      PostToolUse = {
        {
          matcher = ".*",  -- Match all tools
          hooks = {
            {
              type = "command", 
              command = post_command
            }
          }
        }
      }
    }
  }
  
  -- Write hooks configuration
  local settings_file = claude_dir .. '/settings.json'
  local success, err = utils.write_json(settings_file, hooks_config)
  
  if success then
    -- Add .claude to gitignore if needed
    local gitignore_path = project_root .. '/.gitignore'
    local gitignore_content = utils.read_file(gitignore_path) or ''
    
    if not gitignore_content:match('%.claude/') then
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
  local utils = require('nvim-claude.utils')
  
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
    desc = 'Test Claude Code hooks'
  })
  
  vim.api.nvim_create_user_command('ClaudeTestDiff', function()
    local utils = require('nvim-claude.utils')
    
    -- Check if we're in a git repository
    local git_root = utils.get_project_root()
    if not git_root then
      vim.notify('Not in a git repository', vim.log.levels.WARN)
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
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    local stash_msg = string.format('[claude-test] %s', timestamp)
    
    local stash_cmd = string.format('cd "%s" && git stash push -u -m "%s"', git_root, stash_msg)
    local stash_result, stash_err = utils.exec(stash_cmd)
    
    if stash_err then
      vim.notify('Failed to create test stash: ' .. stash_err, vim.log.levels.ERROR)
      return
    end
    
    -- Trigger diff review with the stash (no pre-edit ref for manual test)
    local diff_review = require('nvim-claude.diff-review')
    diff_review.handle_claude_edit('stash@{0}', nil)
    
    -- Pop the stash to restore changes
    vim.defer_fn(function()
      local pop_cmd = string.format('cd "%s" && git stash pop --quiet', git_root)
      utils.exec(pop_cmd)
      vim.cmd('checktime')  -- Refresh buffers
    end, 100)
  end, {
    desc = 'Test Claude diff review with current changes'
  })
  
  vim.api.nvim_create_user_command('ClaudeInstallHooks', function()
    M.install_hooks()
  end, {
    desc = 'Install Claude Code hooks for this project'
  })
  
  vim.api.nvim_create_user_command('ClaudeUninstallHooks', function()
    M.uninstall_hooks()
  end, {
    desc = 'Uninstall Claude Code hooks for this project'
  })
end

-- Cleanup old Claude commits and temp files
function M.cleanup_old_commits()
  local utils = require('nvim-claude.utils')
  
  local git_root = utils.get_project_root()
  if not git_root then
    return
  end
  
  -- Clean up old temp files
  local temp_files = {
    '/tmp/claude-pre-edit-commit',
    '/tmp/claude-baseline-commit',
    '/tmp/claude-last-snapshot',
    '/tmp/claude-hook-test.log'
  }
  
  for _, file in ipairs(temp_files) do
    if vim.fn.filereadable(file) == 1 then
      vim.fn.delete(file)
    end
  end
  
  -- Clean up old Claude commits (keep only the last 5)
  local log_cmd = string.format('cd "%s" && git log --oneline --grep="claude-" --grep="claude-baseline" --grep="claude-pre-edit" --all --max-count=10', git_root)
  local log_result = utils.exec(log_cmd)
  
  if log_result and log_result ~= '' then
    local commits = {}
    for line in log_result:gmatch('[^\n]+') do
      local hash = line:match('^(%w+)')
      if hash then
        table.insert(commits, hash)
      end
    end
    
    -- Keep only the last 5 Claude commits, remove the rest
    if #commits > 5 then
      for i = 6, #commits do
        local reset_cmd = string.format('cd "%s" && git rebase --onto %s^ %s', git_root, commits[i], commits[i])
        utils.exec(reset_cmd)
      end
      vim.notify('Cleaned up old Claude commits', vim.log.levels.DEBUG)
    end
  end
end

return M