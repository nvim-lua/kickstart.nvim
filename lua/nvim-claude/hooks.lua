-- Claude Code hooks integration for nvim-claude
local M = {}

-- Track hook state
M.pre_edit_commit = nil

function M.setup()
  -- Auto-cleanup old Claude commits on startup
  vim.defer_fn(function()
    M.cleanup_old_commits()
  end, 200)
end

-- Pre-tool-use hook: Create baseline commit only if one doesn't exist
function M.pre_tool_use_hook()
  local utils = require 'nvim-claude.utils'

  -- Check if we're in a git repository
  local git_root = utils.get_project_root()
  if not git_root then
    return
  end

  -- Check if we already have a baseline commit
  local baseline_file = '/tmp/claude-baseline-commit'
  local existing_baseline = utils.read_file(baseline_file)

  if existing_baseline and existing_baseline ~= '' then
    existing_baseline = existing_baseline:gsub('%s+', '')
    -- Verify the baseline commit still exists
    local check_cmd = string.format('cd "%s" && git rev-parse --verify %s^{commit} 2>/dev/null', git_root, existing_baseline)
    local check_result, check_err = utils.exec(check_cmd)

    -- If we got a result and no error, the commit exists
    if check_result and not check_err and check_result:match('^%x+') then
      -- Baseline is valid, keep using it
      M.baseline_commit = existing_baseline
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
    return
  end

  -- Create a temporary commit
  local commit_cmd = string.format('cd "%s" && git commit -m "%s" --allow-empty', git_root, commit_msg)
  local commit_result, commit_err = utils.exec(commit_cmd)

  if commit_err and not commit_err:match 'nothing to commit' then
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
end

-- Post-tool-use hook: Create stash of Claude's changes and trigger diff review
function M.post_tool_use_hook()
  -- Run directly without vim.schedule for testing
  local utils = require 'nvim-claude.utils'

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
  for line in status_result:gmatch '[^\n]+' do
    local file = line:match '^.M (.+)$' or line:match '^M. (.+)$' or line:match '^.. (.+)$'
    if file then
      table.insert(modified_files, file)
    end
  end

  -- Get the baseline commit reference first
  local baseline_ref = utils.read_file '/tmp/claude-baseline-commit'
  if baseline_ref then
    baseline_ref = baseline_ref:gsub('%s+', '') -- trim whitespace
  end

  -- Create a stash of Claude's changes (but keep them in working directory)
  local timestamp = os.date '%Y-%m-%d %H:%M:%S'
  local stash_msg = string.format('[claude-edit] %s', timestamp)

  -- Use git stash create to create stash without removing changes
  local stash_cmd = string.format('cd "%s" && git stash create -u', git_root)
  local stash_hash, stash_err = utils.exec(stash_cmd)

  if not stash_err and stash_hash and stash_hash ~= '' then
    -- Store the stash with a message
    stash_hash = stash_hash:gsub('%s+', '') -- trim whitespace
    local store_cmd = string.format('cd "%s" && git stash store -m "%s" %s', git_root, stash_msg, stash_hash)
    utils.exec(store_cmd)

    -- Check if any modified files are currently open in buffers
    local inline_diff = require 'nvim-claude.inline-diff'
    local opened_inline = false

    for _, file in ipairs(modified_files) do
      local full_path = git_root .. '/' .. file

      -- Find buffer with this file
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name == full_path or buf_name:match('/' .. file:gsub('([^%w])', '%%%1') .. '$') then
            -- Get the original content (from baseline)
            local baseline_cmd = string.format('cd "%s" && git show %s:%s 2>/dev/null', git_root, baseline_ref or 'HEAD', file)
            local original_content, orig_err = utils.exec(baseline_cmd)

            if not orig_err and original_content then
              -- Get current content
              local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
              local current_content = table.concat(current_lines, '\n')

              -- Show inline diff
              inline_diff.show_inline_diff(buf, original_content, current_content)
              opened_inline = true

              -- Switch to that buffer if it's not the current one
              if buf ~= vim.api.nvim_get_current_buf() then
                vim.api.nvim_set_current_buf(buf)
              end

              break -- Only show inline diff for first matching buffer
            end
          end
        end
      end

      if opened_inline then
        break
      end
    end

    -- If no inline diff was shown, fall back to regular diff review
    if not opened_inline then
      -- Trigger diff review - show Claude stashes against baseline
      local ok, diff_review = pcall(require, 'nvim-claude.diff-review')
      if ok then
        diff_review.handle_claude_stashes(baseline_ref)
      else
      end
    end
  else
  end
end

-- Test inline diff manually
function M.test_inline_diff()
  vim.notify('Testing inline diff manually...', vim.log.levels.INFO)

  local utils = require 'nvim-claude.utils'
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
  else
    -- Fall back to git baseline
    local baseline_ref = utils.read_file '/tmp/claude-baseline-commit' or 'HEAD'
    baseline_ref = baseline_ref:gsub('%s+', '')

    local baseline_cmd = string.format('cd "%s" && git show %s:%s 2>/dev/null', git_root, baseline_ref, relative_path)
    local git_err
    original_content, git_err = utils.exec(baseline_cmd)

    if git_err then
      vim.notify('Failed to get baseline content: ' .. git_err, vim.log.levels.ERROR)
      return
    end
    vim.notify('Using git baseline', vim.log.levels.INFO)
  end

  -- Get current content
  local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local current_content = table.concat(current_lines, '\n')

  -- Show inline diff
  inline_diff.show_inline_diff(bufnr, original_content, current_content)
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

  vim.api.nvim_create_user_command('ClaudeUpdateBaseline', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local current_content = table.concat(current_lines, '\n')

    local inline_diff = require 'nvim-claude.inline-diff'
    inline_diff.original_content[bufnr] = current_content

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
end

-- Cleanup old Claude commits and temp files
function M.cleanup_old_commits()
  local utils = require 'nvim-claude.utils'

  local git_root = utils.get_project_root()
  if not git_root then
    return
  end

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

  -- Clean up old Claude commits (keep only the last 5)
  local log_cmd =
    string.format('cd "%s" && git log --oneline --grep="claude-" --grep="claude-baseline" --grep="claude-pre-edit" --all --max-count=10', git_root)
  local log_result = utils.exec(log_cmd)

  if log_result and log_result ~= '' then
    local commits = {}
    for line in log_result:gmatch '[^\n]+' do
      local hash = line:match '^(%w+)'
      if hash then
        table.insert(commits, hash)
      end
    end

    -- Keep only the last 5 Claude commits, remove the rest
    -- DISABLED: This was causing rebases that broke the workflow
    -- if #commits > 5 then
    --   for i = 6, #commits do
    --     local reset_cmd = string.format('cd "%s" && git rebase --onto %s^ %s', git_root, commits[i], commits[i])
    --     utils.exec(reset_cmd)
    --   end
    --   vim.notify('Cleaned up old Claude commits', vim.log.levels.DEBUG)
    -- end
  end
end

return M
