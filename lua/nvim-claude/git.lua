-- Git operations module for nvim-claude
local M = {}
local utils = require('nvim-claude.utils')

M.config = {}

function M.setup(config)
  M.config = config or {}
end

-- Check if git worktrees are supported
function M.supports_worktrees()
  local result = utils.exec('git worktree list 2>/dev/null')
  return result ~= nil and not result:match('error')
end

-- Get list of existing worktrees
function M.list_worktrees()
  local result = utils.exec('git worktree list --porcelain')
  if not result then return {} end
  
  local worktrees = {}
  local current = {}
  
  for line in result:gmatch('[^\n]+') do
    if line:match('^worktree ') then
      if current.path then
        table.insert(worktrees, current)
      end
      current = { path = line:match('^worktree (.+)') }
    elseif line:match('^HEAD ') then
      current.head = line:match('^HEAD (.+)')
    elseif line:match('^branch ') then
      current.branch = line:match('^branch (.+)')
    end
  end
  
  if current.path then
    table.insert(worktrees, current)
  end
  
  return worktrees
end

-- Create a new worktree
function M.create_worktree(path, branch)
  branch = branch or 'main'
  
  -- Check if worktree already exists
  local worktrees = M.list_worktrees()
  for _, wt in ipairs(worktrees) do
    if wt.path == path then
      return true, wt
    end
  end
  
  -- Create worktree
  local cmd = string.format('git worktree add "%s" "%s" 2>&1', path, branch)
  local result, err = utils.exec(cmd)
  
  if err then
    return false, result
  end
  
  return true, { path = path, branch = branch }
end

-- Remove a worktree
function M.remove_worktree(path)
  local cmd = string.format('git worktree remove "%s" --force 2>&1', path)
  local _, err = utils.exec(cmd)
  return err == nil
end

-- Add entry to .gitignore
function M.add_to_gitignore(pattern)
  local gitignore_path = utils.get_project_root() .. '/.gitignore'
  
  -- Read existing content
  local content = utils.read_file(gitignore_path) or ''
  
  -- Check if pattern already exists
  if content:match('\n' .. pattern:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1') .. '\n') or
     content:match('^' .. pattern:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1') .. '\n') then
    return true
  end
  
  -- Append pattern
  if not content:match('\n$') and content ~= '' then
    content = content .. '\n'
  end
  content = content .. pattern .. '\n'
  
  return utils.write_file(gitignore_path, content)
end

-- Get current branch
function M.current_branch()
  local result = utils.exec('git branch --show-current 2>/dev/null')
  if result then
    return result:gsub('\n', '')
  end
  return nil
end

-- Get git status
function M.status(path)
  local cmd = 'git status --porcelain'
  if path then
    cmd = string.format('cd "%s" && %s', path, cmd)
  end
  
  local result = utils.exec(cmd)
  if not result then return {} end
  
  local files = {}
  for line in result:gmatch('[^\n]+') do
    local status, file = line:match('^(..) (.+)$')
    if status and file then
      table.insert(files, { status = status, file = file })
    end
  end
  
  return files
end

-- Get diff between two paths
function M.diff(path1, path2)
  local cmd = string.format(
    'git diff --no-index --name-status "%s" "%s" 2>/dev/null',
    path1,
    path2
  )
  local result = utils.exec(cmd)
  return result or ''
end

return M 