-- Tmux interaction module for nvim-claude
local M = {}
local utils = require('nvim-claude.utils')

M.config = {}

function M.setup(config)
  M.config = config or {}
end

-- Find Claude pane by checking running command
function M.find_claude_pane()
  -- Get list of panes with their PIDs and current command
  local cmd = "tmux list-panes -F '#{pane_id}:#{pane_pid}:#{pane_title}:#{pane_current_command}'"
  local result = utils.exec(cmd)
  
  if result and result ~= '' then
    -- Check each pane
    for line in result:gmatch('[^\n]+') do
      local pane_id, pane_pid, pane_title, pane_cmd = line:match('^([^:]+):([^:]+):([^:]*):(.*)$')
      if pane_id and pane_pid then
        -- Check by title first (our created panes)
        if pane_title and pane_title == (M.config.pane_title or 'claude-chat') then
          return pane_id
        end
        
        -- Check if title contains Claude Code indicators (Anthropic symbol, "claude", "Claude")
        if pane_title and (pane_title:match('✳') or pane_title:match('[Cc]laude')) then
          return pane_id
        end
        
        -- Check if current command is claude-related
        if pane_cmd and pane_cmd:match('claude') then
          return pane_id
        end
        
        -- Check if any child process of this pane is running claude or claude-code
        -- This handles cases where claude is run under a shell
        local check_cmd = string.format(
          "ps -ef | awk '$3 == %s' | grep -c -E '(claude|claude-code)' 2>/dev/null",
          pane_pid
        )
        local count_result = utils.exec(check_cmd)
        if count_result and tonumber(count_result) and tonumber(count_result) > 0 then
          return pane_id
        end
      end
    end
  end
  
  return nil
end

-- Create new tmux pane for Claude (or return existing)
function M.create_pane(command)
  local existing = M.find_claude_pane()
  if existing then
    -- Just select the existing pane, don't create a new one
    local _, err = utils.exec('tmux select-pane -t ' .. existing)
    if err then
      -- Pane might have been closed, continue to create new one
      vim.notify('Claude pane no longer exists, creating new one', vim.log.levels.INFO)
    else
      return existing
    end
  end

  -- Build size option safely
  local size_opt = ''
  if M.config.split_size and tonumber(M.config.split_size) then
    local size = tonumber(M.config.split_size)
    if utils.tmux_supports_length_percent() then
      size_opt = '-l ' .. tostring(size) .. '%'
    else
      size_opt = '-p ' .. tostring(size)
    end
  end

  local split_cmd = M.config.split_direction == 'v' and 'split-window -v' or 'split-window -h'

  -- Build command parts to avoid double spaces
  local parts = { 'tmux', split_cmd }
  if size_opt ~= '' then table.insert(parts, size_opt) end
  table.insert(parts, '-P')
  local cmd = table.concat(parts, ' ')
  if command then
    cmd = cmd .. " '" .. command .. "'"
  end

  local result, err = utils.exec(cmd)
  if err or not result or result == '' or result:match('error') then
    vim.notify('nvim-claude: tmux split failed: ' .. (err or result or 'unknown'), vim.log.levels.ERROR)
    return nil
  end

  local pane_id = result:gsub('\n', '')
  utils.exec(string.format("tmux select-pane -t %s -T '%s'", pane_id, M.config.pane_title or 'claude-chat'))
  
  -- Launch command in the new pane if provided
  if command and command ~= '' then
    M.send_to_pane(pane_id, command)
  end
  
  return pane_id
end

-- Send keys to a pane (single line with Enter)
function M.send_to_pane(pane_id, text)
  if not pane_id then return false end
  
  -- Escape single quotes in text
  text = text:gsub("'", "'\"'\"'")
  
  local cmd = string.format(
    "tmux send-keys -t %s '%s' Enter",
    pane_id,
    text
  )
  
  local _, err = utils.exec(cmd)
  return err == nil
end

-- Send multi-line text to a pane (for batched content)
function M.send_text_to_pane(pane_id, text)
  if not pane_id then return false end
  
  -- Create a temporary file to hold the text
  local tmpfile = os.tmpname()
  local file = io.open(tmpfile, 'w')
  if not file then
    vim.notify('Failed to create temporary file for text', vim.log.levels.ERROR)
    return false
  end
  
  file:write(text)
  file:close()
  
  -- Use tmux load-buffer and paste-buffer to send the content
  local cmd = string.format(
    "tmux load-buffer -t %s '%s' && tmux paste-buffer -t %s && rm '%s'",
    pane_id, tmpfile, pane_id, tmpfile
  )
  
  local _, err = utils.exec(cmd)
  if err then
    -- Clean up temp file on error
    os.remove(tmpfile)
    vim.notify('Failed to send text to pane: ' .. err, vim.log.levels.ERROR)
    return false
  end
  
  -- Don't send Enter after pasting to avoid submitting the message
  -- User can manually submit when ready
  
  return true
end

-- Create new tmux window for agent
function M.create_agent_window(name, cwd)
  local base_cmd = string.format("tmux new-window -n '%s'", name)
  if cwd and cwd ~= '' then
    base_cmd = base_cmd .. string.format(" -c '%s'", cwd)
  end

  local cmd_with_fmt = base_cmd .. " -P -F '#{window_id}'"

  -- Try with -F first (preferred)
  local result, err = utils.exec(cmd_with_fmt)
  if not err and result and result ~= '' and not result:match('error') then
    return result:gsub('\n', '')
  end

  -- Fallback: simple -P
  local cmd_simple = base_cmd .. ' -P'
  result, err = utils.exec(cmd_simple)
  if not err and result and result ~= '' then
    return result:gsub('\n', '')
  end

  vim.notify('nvim-claude: tmux new-window failed: ' .. (err or result or 'unknown'), vim.log.levels.ERROR)
  return nil
end

-- Send keys to an entire window (select-pane 0)
function M.send_to_window(window_id, text)
  if not window_id then return false end
  text = text:gsub("'", "'\"'\"'")
  -- Send to the window's active pane (no .0 suffix)
  local cmd = string.format("tmux send-keys -t %s '%s' Enter", window_id, text)
  local _, err = utils.exec(cmd)
  return err == nil
end

-- Switch to window
function M.switch_to_window(window_id)
  local cmd = 'tmux select-window -t ' .. window_id
  local _, err = utils.exec(cmd)
  return err == nil
end

-- Kill pane or window
function M.kill_pane(pane_id)
  local cmd = 'tmux kill-pane -t ' .. pane_id
  local _, err = utils.exec(cmd)
  return err == nil
end

-- Check if tmux is running
function M.is_inside_tmux()
  -- Check environment variable first
  if os.getenv('TMUX') then
    return true
  end
  
  -- Fallback: try to get current session name
  local result = utils.exec('tmux display-message -p "#{session_name}" 2>/dev/null')
  return result and result ~= '' and not result:match('error')
end

-- Validate tmux availability
function M.validate()
  if not utils.has_tmux() then
    vim.notify('tmux not found. Please install tmux.', vim.log.levels.ERROR)
    return false
  end
  
  if not M.is_inside_tmux() then
    vim.notify('Not inside tmux session. Please run nvim inside tmux.', vim.log.levels.ERROR)
    return false
  end
  
  return true
end

-- Split a given window and return the new pane id
-- direction: 'h' (horizontal/right) or 'v' (vertical/bottom)
-- size_percent: number (percentage)
function M.split_window(window_id, direction, size_percent)
  direction = direction == 'v' and '-v' or '-h'

  local size_opt = ''
  if size_percent and tonumber(size_percent) then
    local size = tonumber(size_percent)
    if utils.tmux_supports_length_percent() then
      size_opt = string.format('-l %s%%', size)
    else
      size_opt = string.format('-p %s', size)
    end
  end

  -- Build command
  local parts = {
    'tmux',
    'split-window',
    direction,
  }
  if size_opt ~= '' then table.insert(parts, size_opt) end
  table.insert(parts, '-P -F "#{pane_id}"')
  table.insert(parts, '-t ' .. window_id)

  local cmd = table.concat(parts, ' ')
  local pane_id, err = utils.exec(cmd)
  if err or not pane_id or pane_id == '' then
    vim.notify('nvim-claude: tmux split-window failed: ' .. (err or pane_id or 'unknown'), vim.log.levels.ERROR)
    return nil
  end
  return pane_id:gsub('\n', '')
end

return M 