-- Utility functions for nvim-claude
-- TEST EDIT #2: Testing multi-file accept
local M = {}

-- Check if we're in a git repository
function M.is_git_repo()
  local handle = io.popen('git rev-parse --git-dir 2>/dev/null')
  if handle then
    local result = handle:read('*a')
    handle:close()
    return result ~= ''
  end
  return false
end

-- Get project root (git root or current working directory)
function M.get_project_root()
  if M.is_git_repo() then
    local handle = io.popen('git rev-parse --show-toplevel 2>/dev/null')
    if handle then
      local root = handle:read('*a'):gsub('\n', '')
      handle:close()
      return root
    end
  end
  return vim.fn.getcwd()
end

-- Create directory if it doesn't exist
function M.ensure_dir(path)
  local stat = vim.loop.fs_stat(path)
  if not stat then
    vim.fn.mkdir(path, 'p')
    return true
  end
  return stat.type == 'directory'
end

-- Read file contents
function M.read_file(path)
  local file = io.open(path, 'r')
  if not file then return nil end
  local content = file:read('*a')
  file:close()
  return content
end

-- Write file contents
function M.write_file(path, content)
  local file = io.open(path, 'w')
  if not file then return false end
  file:write(content)
  file:close()
  return true
end

-- Check if file exists
function M.file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == 'file'
end

-- Generate timestamp string
function M.timestamp()
  return os.date('%Y-%m-%d-%H%M%S')
end

-- Generate agent directory name
function M.agent_dirname(task)
  -- Sanitize task name for filesystem
  local safe_task = task:gsub('[^%w%-_]', '-'):gsub('%-+', '-'):sub(1, 50)
  return string.format('agent-%s-%s', M.timestamp(), safe_task)
end

-- Execute shell command and return output
function M.exec(cmd)
  local handle = io.popen(cmd .. ' 2>&1')
  if not handle then return nil, 'Failed to execute command' end
  local result = handle:read('*a')
  local ok = handle:close()
  if ok then
    return result, nil
  else
    return result, result
  end
end

-- Check if tmux is available
function M.has_tmux()
  local result = M.exec('which tmux')
  return result and result:match('/tmux')
end

-- Get current tmux session
function M.get_tmux_session()
  local result = M.exec('tmux display-message -p "#{session_name}" 2>/dev/null')
  if result and result ~= '' then
    return result:gsub('\n', '')
  end
  return nil
end

-- Get tmux version as number (e.g., 3.4) or 0 if unknown
function M.tmux_version()
  local result = M.exec('tmux -V 2>/dev/null')
  if not result then return 0 end
  -- Expected output: "tmux 3.4"
  local ver = result:match('tmux%s+([0-9]+%.[0-9]+)')
  return tonumber(ver) or 0
end

-- Determine if tmux supports the new -l <percent>% syntax (>= 3.4)
function M.tmux_supports_length_percent()
  return M.tmux_version() >= 3.4
end

-- Write JSON to file
function M.write_json(path, data)
  local success, json = pcall(vim.fn.json_encode, data)
  if not success then
    return false, 'Failed to encode JSON: ' .. json
  end
  
  local file = io.open(path, 'w')
  if not file then 
    return false, 'Failed to open file for writing: ' .. path
  end
  
  -- Pretty print JSON
  local formatted = json:gsub('},{', '},\n    {'):gsub('\\{', '{\n  '):gsub('\\}', '\n}')
  file:write(formatted)
  file:close()
  return true, nil
end

-- Read JSON from file
function M.read_json(path)
  local content = M.read_file(path)
  if not content then
    return nil, 'Failed to read file: ' .. path
  end
  
  local success, data = pcall(vim.fn.json_decode, content)
  if not success then
    return nil, 'Failed to decode JSON: ' .. data
  end
  
  return data, nil
end

return M 