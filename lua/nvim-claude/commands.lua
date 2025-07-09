-- Commands module for nvim-claude
local M = {}

-- Reference to main module
local claude = nil

-- Setup commands
function M.setup(claude_module)
  claude = claude_module
  
  -- ClaudeChat command
  vim.api.nvim_create_user_command('ClaudeChat', function()
    M.claude_chat()
  end, {
    desc = 'Open Claude in a tmux pane'
  })
  
  -- ClaudeSendBuffer command
  vim.api.nvim_create_user_command('ClaudeSendBuffer', function()
    M.send_buffer()
  end, {
    desc = 'Send current buffer to Claude'
  })
  
  -- ClaudeSendSelection command (visual mode)
  vim.api.nvim_create_user_command('ClaudeSendSelection', function(opts)
    M.send_selection(opts.line1, opts.line2)
  end, {
    desc = 'Send selected text to Claude',
    range = true
  })
  
  -- ClaudeSendHunk command
  vim.api.nvim_create_user_command('ClaudeSendHunk', function()
    M.send_hunk()
  end, {
    desc = 'Send git hunk under cursor to Claude'
  })
  
  -- ClaudeBg command
  vim.api.nvim_create_user_command('ClaudeBg', function(opts)
    M.claude_bg(opts.args)
  end, {
    desc = 'Start a background Claude agent',
    nargs = '+',
    complete = function() return {} end
  })
  
  -- ClaudeAgents command
  vim.api.nvim_create_user_command('ClaudeAgents', function()
    M.list_agents()
  end, {
    desc = 'List all Claude agents'
  })
  
  -- ClaudeKill command
  vim.api.nvim_create_user_command('ClaudeKill', function(opts)
    M.kill_agent(opts.args)
  end, {
    desc = 'Kill a Claude agent',
    nargs = '?',
    complete = function()
      local agents = claude.registry.get_project_agents()
      local completions = {}
      for id, agent in pairs(agents) do
        if agent.status == 'active' then
          table.insert(completions, id)
        end
      end
      return completions
    end
  })
  
  -- ClaudeClean command
  vim.api.nvim_create_user_command('ClaudeClean', function()
    M.clean_agents()
  end, {
    desc = 'Clean up old Claude agents'
  })
  
  -- ClaudeDebug command
  vim.api.nvim_create_user_command('ClaudeDebug', function()
    M.debug_panes()
  end, {
    desc = 'Debug Claude pane detection'
  })
end

-- Open Claude chat
function M.claude_chat()
  if not claude.tmux.validate() then
    return
  end
  
  local pane_id = claude.tmux.create_pane('claude')
  if pane_id then
    vim.notify('Claude chat opened in pane ' .. pane_id, vim.log.levels.INFO)
  else
    vim.notify('Failed to create Claude pane', vim.log.levels.ERROR)
  end
end

-- Send current buffer to Claude
function M.send_buffer()
  if not claude.tmux.validate() then
    return
  end
  
  local pane_id = claude.tmux.find_claude_pane()
  if not pane_id then
    pane_id = claude.tmux.create_pane('claude')
  end
  
  if not pane_id then
    vim.notify('Failed to find or create Claude pane', vim.log.levels.ERROR)
    return
  end
  
  -- Get buffer info
  local filename = vim.fn.expand('%:t')
  local filetype = vim.bo.filetype
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  
  -- Build complete message as one string
  local message_parts = {
    string.format('Here is `%s` (%s):', filename, filetype),
    '```' .. (filetype ~= '' and filetype or ''),
  }
  
  -- Add all lines
  for _, line in ipairs(lines) do
    table.insert(message_parts, line)
  end
  
  table.insert(message_parts, '```')
  
  -- Send as one batched message
  local full_message = table.concat(message_parts, '\n')
  claude.tmux.send_text_to_pane(pane_id, full_message)
  
  vim.notify('Buffer sent to Claude', vim.log.levels.INFO)
end

-- Send selection to Claude
function M.send_selection(line1, line2)
  if not claude.tmux.validate() then
    return
  end
  
  local pane_id = claude.tmux.find_claude_pane()
  if not pane_id then
    pane_id = claude.tmux.create_pane('claude')
  end
  
  if not pane_id then
    vim.notify('Failed to find or create Claude pane', vim.log.levels.ERROR)
    return
  end
  
  -- Get selected lines
  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  
  -- Build complete message as one string
  local filename = vim.fn.expand('%:t')
  local filetype = vim.bo.filetype
  local message_parts = {
    string.format('Selection from `%s` (lines %d-%d):', filename, line1, line2),
    '```' .. (filetype ~= '' and filetype or ''),
  }
  
  -- Add all lines
  for _, line in ipairs(lines) do
    table.insert(message_parts, line)
  end
  
  table.insert(message_parts, '```')
  
  -- Send as one batched message
  local full_message = table.concat(message_parts, '\n')
  claude.tmux.send_text_to_pane(pane_id, full_message)
  
  vim.notify('Selection sent to Claude', vim.log.levels.INFO)
end

-- Send git hunk under cursor to Claude
function M.send_hunk()
  if not claude.tmux.validate() then
    return
  end
  
  local pane_id = claude.tmux.find_claude_pane()
  if not pane_id then
    pane_id = claude.tmux.create_pane('claude')
  end
  
  if not pane_id then
    vim.notify('Failed to find or create Claude pane', vim.log.levels.ERROR)
    return
  end
  
  -- Get current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor_pos[1]
  
  -- Get git diff to find hunks
  local filename = vim.fn.expand('%:p')
  local relative_filename = vim.fn.expand('%')
  
  if not filename or filename == '' then
    vim.notify('No file to get hunk from', vim.log.levels.ERROR)
    return
  end
  
  -- Get git diff for this file
  local cmd = string.format('git diff HEAD -- "%s"', filename)
  local diff_output = claude.utils.exec(cmd)
  
  if not diff_output or diff_output == '' then
    vim.notify('No git changes found in current file', vim.log.levels.INFO)
    return
  end
  
  -- Parse diff to find hunk containing current line
  local hunk_lines = {}
  local hunk_start = nil
  local hunk_end = nil
  local found_hunk = false
  
  for line in diff_output:gmatch('[^\n]+') do
    if line:match('^@@') then
      -- Parse hunk header: @@ -oldstart,oldcount +newstart,newcount @@
      local newstart, newcount = line:match('^@@ %-%d+,%d+ %+(%d+),(%d+) @@')
      if newstart and newcount then
        newstart = tonumber(newstart)
        newcount = tonumber(newcount)
        
        if current_line >= newstart and current_line < newstart + newcount then
          found_hunk = true
          hunk_start = newstart
          hunk_end = newstart + newcount - 1
          table.insert(hunk_lines, line) -- Include the @@ line
        else
          found_hunk = false
          hunk_lines = {}
        end
      end
    elseif found_hunk then
      table.insert(hunk_lines, line)
    end
  end
  
  if #hunk_lines == 0 then
    vim.notify('No git hunk found at cursor position', vim.log.levels.INFO)
    return
  end
  
  -- Build message
  local message_parts = {
    string.format('Git hunk from `%s` (around line %d):', relative_filename, current_line),
    '```diff'
  }
  
  -- Add hunk lines
  for _, line in ipairs(hunk_lines) do
    table.insert(message_parts, line)
  end
  
  table.insert(message_parts, '```')
  
  -- Send as one batched message
  local full_message = table.concat(message_parts, '\n')
  claude.tmux.send_text_to_pane(pane_id, full_message)
  
  vim.notify('Git hunk sent to Claude', vim.log.levels.INFO)
end

-- Start background agent
function M.claude_bg(task)
  if not claude.tmux.validate() then
    return
  end
  
  if not task or task == '' then
    vim.notify('Please provide a task description', vim.log.levels.ERROR)
    return
  end
  
  -- Create agent work directory
  local project_root = claude.utils.get_project_root()
  local work_dir = project_root .. '/' .. claude.config.agents.work_dir
  local agent_dir = work_dir .. '/' .. claude.utils.agent_dirname(task)
  
  -- Ensure work directory exists
  if not claude.utils.ensure_dir(work_dir) then
    vim.notify('Failed to create work directory', vim.log.levels.ERROR)
    return
  end
  
  -- Add to gitignore if needed
  if claude.config.agents.auto_gitignore then
    claude.git.add_to_gitignore(claude.config.agents.work_dir .. '/')
  end
  
  -- Create agent directory
  if not claude.utils.ensure_dir(agent_dir) then
    vim.notify('Failed to create agent directory', vim.log.levels.ERROR)
    return
  end
  
  -- Create worktree or clone
  local success, result
  if claude.config.agents.use_worktrees and claude.git.supports_worktrees() then
    local branch = claude.git.current_branch() or 'main'
    success, result = claude.git.create_worktree(agent_dir, branch)
    if not success then
      vim.notify('Failed to create worktree: ' .. tostring(result), vim.log.levels.ERROR)
      return
    end
  else
    -- Fallback to copy (simplified for now)
    local cmd = string.format('cp -r "%s"/* "%s"/', project_root, agent_dir)
    local _, err = claude.utils.exec(cmd)
    if err then
      vim.notify('Failed to copy project: ' .. err, vim.log.levels.ERROR)
      return
    end
  end
  
  -- Create mission log
  local log_content = string.format(
    "Agent Mission Log\n================\n\nTask: %s\nStarted: %s\nStatus: Active\n\n",
    task,
    os.date('%Y-%m-%d %H:%M:%S')
  )
  claude.utils.write_file(agent_dir .. '/mission.log', log_content)
  
  -- Check agent limit
  local active_count = claude.registry.get_active_count()
  if active_count >= claude.config.agents.max_agents then
    vim.notify(string.format(
      'Agent limit reached (%d/%d). Complete or kill existing agents first.',
      active_count,
      claude.config.agents.max_agents
    ), vim.log.levels.ERROR)
    return
  end
  
  -- Create tmux window for agent
  local window_name = 'claude-' .. claude.utils.timestamp()
  local window_id = claude.tmux.create_agent_window(window_name, agent_dir)
  
  if window_id then
    -- Register agent
    local agent_id = claude.registry.register(task, agent_dir, window_id, window_name)
    
    -- Update mission log with agent ID
    local log_content = claude.utils.read_file(agent_dir .. '/mission.log')
    log_content = log_content .. string.format("\nAgent ID: %s\n", agent_id)
    claude.utils.write_file(agent_dir .. '/mission.log', log_content)
    
    -- In first pane (0) open Neovim
    claude.tmux.send_to_window(window_id, 'nvim .')

    -- Split right side 40% and open Claude
    local pane_claude = claude.tmux.split_window(window_id, 'h', 40)
    if pane_claude then
      claude.tmux.send_to_pane(pane_claude, 'claude --dangerously-skip-permissions')
      
      -- Send initial task description to Claude
      vim.wait(1000) -- Wait for Claude to start
      local task_msg = string.format(
        "I'm an autonomous agent working on the following task:\n\n%s\n\n" ..
        "My workspace is: %s\n" ..
        "I should work independently to complete this task.",
        task, agent_dir
      )
      claude.tmux.send_text_to_pane(pane_claude, task_msg)
    end

    vim.notify(string.format(
      'Background agent started\nID: %s\nTask: %s\nWorkspace: %s\nWindow: %s',
      agent_id,
      task,
      agent_dir,
      window_name
    ), vim.log.levels.INFO)
  else
    vim.notify('Failed to create agent window', vim.log.levels.ERROR)
  end
end

-- List all agents
function M.list_agents()
  -- Validate agents first
  claude.registry.validate_agents()
  
  local agents = claude.registry.get_project_agents()
  if vim.tbl_isempty(agents) then
    vim.notify('No agents found for this project', vim.log.levels.INFO)
    return
  end
  
  -- Create a simple list view
  local lines = { 'Claude Agents:', '' }
  
  -- Sort agents by start time
  local sorted_agents = {}
  for id, agent in pairs(agents) do
    agent.id = id
    table.insert(sorted_agents, agent)
  end
  table.sort(sorted_agents, function(a, b) return a.start_time > b.start_time end)
  
  for _, agent in ipairs(sorted_agents) do
    table.insert(lines, claude.registry.format_agent(agent))
    table.insert(lines, '  ID: ' .. agent.id)
    table.insert(lines, '  Window: ' .. (agent.window_name or 'unknown'))
    table.insert(lines, '')
  end
  
  -- Display in a floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  
  local width = 60
  local height = math.min(#lines, 20)
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
  }
  
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:Comment')
  
  -- Close on q or Esc
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { silent = true })
end

-- Kill an agent
function M.kill_agent(agent_id)
  if not agent_id or agent_id == '' then
    -- Show selection UI for agent killing
    M.show_kill_agent_ui()
    return
  end
  
  local agent = claude.registry.get(agent_id)
  if not agent then
    vim.notify('Agent not found: ' .. agent_id, vim.log.levels.ERROR)
    return
  end
  
  -- Kill tmux window
  if agent.window_id then
    local cmd = 'tmux kill-window -t ' .. agent.window_id
    claude.utils.exec(cmd)
  end
  
  -- Update registry
  claude.registry.update_status(agent_id, 'killed')
  
  vim.notify(string.format('Agent killed: %s (%s)', agent_id, agent.task), vim.log.levels.INFO)
end

-- Show agent kill selection UI
function M.show_kill_agent_ui()
  -- Validate agents first
  claude.registry.validate_agents()
  
  local agents = claude.registry.get_project_agents()
  local active_agents = {}
  
  for id, agent in pairs(agents) do
    if agent.status == 'active' then
      agent.id = id
      table.insert(active_agents, agent)
    end
  end
  
  if #active_agents == 0 then
    vim.notify('No active agents to kill', vim.log.levels.INFO)
    return
  end
  
  -- Sort agents by start time
  table.sort(active_agents, function(a, b) return a.start_time > b.start_time end)
  
  -- Track selection state
  local selected = {}
  for i = 1, #active_agents do
    selected[i] = false
  end
  
  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  
  -- Create window
  local width = 80
  local height = math.min(#active_agents * 4 + 4, 25)
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
    title = ' Kill Claude Agents ',
    title_pos = 'center',
  }
  
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:Comment')
  
  -- Function to update display
  local function update_display()
    local lines = { 'Kill Claude Agents (Space: toggle, Y: confirm kill, q: quit):', '' }
    
    for i, agent in ipairs(active_agents) do
      local icon = selected[i] and '●' or '○'
      local formatted = claude.registry.format_agent(agent)
      table.insert(lines, string.format('%s %s', icon, formatted))
      table.insert(lines, '    ID: ' .. agent.id)
      table.insert(lines, '    Window: ' .. (agent.window_name or 'unknown'))
      table.insert(lines, '')
    end
    
    -- Get current cursor position
    local cursor_line = 1
    if win and vim.api.nvim_win_is_valid(win) then
      cursor_line = vim.api.nvim_win_get_cursor(win)[1]
    end
    
    -- Update buffer content
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    
    -- Restore cursor position
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_set_cursor(win, {math.min(cursor_line, #lines), 0})
    end
  end
  
  -- Initial display
  update_display()
  
  -- Set up keybindings
  local function close_window()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  
  local function get_agent_from_line(line)
    if line <= 2 then return nil end -- Header lines
    local agent_index = math.ceil((line - 2) / 4)
    return agent_index <= #active_agents and agent_index or nil
  end
  
  local function toggle_selection()
    local line = vim.api.nvim_win_get_cursor(win)[1]
    local agent_index = get_agent_from_line(line)
    
    if agent_index then
      selected[agent_index] = not selected[agent_index]
      update_display()
    end
  end
  
  local function confirm_kill()
    local selected_agents = {}
    for i, is_selected in ipairs(selected) do
      if is_selected then
        table.insert(selected_agents, active_agents[i])
      end
    end
    
    if #selected_agents == 0 then
      vim.notify('No agents selected', vim.log.levels.INFO)
      return
    end
    
    close_window()
    
    -- Confirm before killing
    local task_list = {}
    for _, agent in ipairs(selected_agents) do
      table.insert(task_list, '• ' .. agent.task:sub(1, 50))
    end
    
    vim.ui.select(
      {'Yes', 'No'},
      {
        prompt = string.format('Kill %d agent(s)?', #selected_agents),
        format_item = function(item)
          if item == 'Yes' then
            return 'Yes - Kill selected agents:\n' .. table.concat(task_list, '\n')
          else
            return 'No - Cancel'
          end
        end
      },
      function(choice)
        if choice == 'Yes' then
          for _, agent in ipairs(selected_agents) do
            M.kill_agent(agent.id)
          end
        end
      end
    )
  end
  
  -- Close on q or Esc
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
    callback = close_window,
    silent = true,
    noremap = true,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', {
    callback = close_window,
    silent = true,
    noremap = true,
  })
  
  -- Space to toggle selection
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Space>', '', {
    callback = toggle_selection,
    silent = true,
    noremap = true,
  })
  
  -- Y to confirm kill
  vim.api.nvim_buf_set_keymap(buf, 'n', 'Y', '', {
    callback = confirm_kill,
    silent = true,
    noremap = true,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'y', '', {
    callback = confirm_kill,
    silent = true,
    noremap = true,
  })
end

-- Clean up old agents
function M.clean_agents()
  local removed = claude.registry.cleanup(claude.config.agents.cleanup_days)
  
  if removed > 0 then
    vim.notify(string.format('Cleaned up %d old agent(s)', removed), vim.log.levels.INFO)
  else
    vim.notify('No old agents to clean up', vim.log.levels.INFO)
  end
end

-- Debug pane detection
function M.debug_panes()
  local utils = require('nvim-claude.utils')
  
  -- Get all panes with details
  local cmd = "tmux list-panes -F '#{pane_id}:#{pane_pid}:#{pane_title}:#{pane_current_command}'"
  local result = utils.exec(cmd)
  
  local lines = { 'Claude Pane Debug Info:', '' }
  
  if result and result ~= '' then
    table.insert(lines, 'All panes:')
    for line in result:gmatch('[^\n]+') do
      local pane_id, pane_pid, pane_title, pane_cmd = line:match('^([^:]+):([^:]+):([^:]*):(.*)$')
      if pane_id and pane_pid then
        table.insert(lines, string.format('  %s: pid=%s, title="%s", cmd="%s"', 
          pane_id, pane_pid, pane_title or '', pane_cmd or ''))
      end
    end
  else
    table.insert(lines, 'No panes found')
  end
  
  table.insert(lines, '')
  
  -- Show detected Claude pane
  local detected_pane = claude.tmux.find_claude_pane()
  if detected_pane then
    table.insert(lines, 'Detected Claude pane: ' .. detected_pane)
  else
    table.insert(lines, 'No Claude pane detected')
  end
  
  -- Display in floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  
  local width = 80
  local height = math.min(#lines + 2, 25)
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
  }
  
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:Comment')
  
  -- Close on q or Esc
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { silent = true })
end

return M 