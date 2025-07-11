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
    nargs = '*',  -- Changed from '+' to '*' to allow zero arguments
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
  
  -- ClaudeSwitch command (DEPRECATED - use ClaudeAgents instead)
  vim.api.nvim_create_user_command('ClaudeSwitch', function(opts)
    vim.notify('ClaudeSwitch is deprecated. Use :ClaudeAgents instead.', vim.log.levels.WARN)
    -- Redirect to ClaudeAgents
    M.list_agents()
  end, {
    desc = '[DEPRECATED] Use :ClaudeAgents instead',
    nargs = '?',
  })
  
  -- ClaudeDebugAgents command
  vim.api.nvim_create_user_command('ClaudeDebugAgents', function()
    local current_dir = vim.fn.getcwd()
    local project_root = claude.utils.get_project_root()
    local all_agents = claude.registry.agents
    local project_agents = claude.registry.get_project_agents()
    
    vim.notify(string.format('Current directory: %s', current_dir), vim.log.levels.INFO)
    vim.notify(string.format('Project root: %s', project_root), vim.log.levels.INFO)
    vim.notify(string.format('Total agents in registry: %d', vim.tbl_count(all_agents)), vim.log.levels.INFO)
    vim.notify(string.format('Project agents count: %d', #project_agents), vim.log.levels.INFO)
    
    for id, agent in pairs(all_agents) do
      vim.notify(string.format('  Agent %s: project=%s, status=%s, task=%s', 
        id, agent.project_root or 'nil', agent.status, 
        (agent.task or ''):match('[^\n]*') or agent.task), vim.log.levels.INFO)
    end
  end, {
    desc = 'Debug agent registry'
  })
  
  -- ClaudeCleanOrphans command - clean orphaned directories
  vim.api.nvim_create_user_command('ClaudeCleanOrphans', function()
    M.clean_orphaned_directories()
  end, {
    desc = 'Clean orphaned agent directories'
  })
  
  -- ClaudeDiffAgent command
  vim.api.nvim_create_user_command('ClaudeDiffAgent', function(opts)
    M.diff_agent(opts.args ~= '' and opts.args or nil)
  end, {
    desc = 'Review agent changes with diffview',
    nargs = '?',
    complete = function()
      local agents = claude.registry.get_project_agents()
      local completions = {}
      for _, agent in ipairs(agents) do
        table.insert(completions, agent.id)
      end
      return completions
    end
  })
  
  -- Debug command to check registry state
  vim.api.nvim_create_user_command('ClaudeDebugRegistry', function()
    local project_root = claude.utils.get_project_root()
    local current_dir = vim.fn.getcwd()
    local all_agents = claude.registry.agents
    local project_agents = claude.registry.get_project_agents()
    
    vim.notify('=== Claude Registry Debug ===', vim.log.levels.INFO)
    vim.notify('Current directory: ' .. current_dir, vim.log.levels.INFO)
    vim.notify('Project root: ' .. project_root, vim.log.levels.INFO)
    vim.notify('Total agents in registry: ' .. vim.tbl_count(all_agents), vim.log.levels.INFO)
    vim.notify('Agents for current project: ' .. #project_agents, vim.log.levels.INFO)
    
    if vim.tbl_count(all_agents) > 0 then
      vim.notify('\nAll agents:', vim.log.levels.INFO)
      for id, agent in pairs(all_agents) do
        vim.notify(string.format('  %s: project_root=%s, work_dir=%s', 
          id, agent.project_root, agent.work_dir), vim.log.levels.INFO)
      end
    end
  end, {
    desc = 'Debug Claude registry state'
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

-- Start background agent with UI
function M.claude_bg(task)
  if not claude.tmux.validate() then
    return
  end
  
  -- If task provided via command line, use old flow for backwards compatibility
  if task and task ~= '' then
    M.create_agent_from_task(task, nil)
    return
  end
  
  -- Otherwise show the new UI
  M.show_agent_creation_ui()
end

-- Show agent creation UI
function M.show_agent_creation_ui()
  -- Start with mission input stage
  M.show_mission_input_ui()
end

-- Stage 1: Mission input with multiline support
function M.show_mission_input_ui()
  -- Create buffer for mission input
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')  -- Nice syntax highlighting
  
  -- Initial content with placeholder
  local lines = {
    '# Agent Mission Description',
    '',
    'Enter your detailed mission description below.',
    'You can use multiple lines and markdown formatting.',
    '',
    '## Task:',
    '',
    '(Type your task here...)',
    '',
    '## Goals:',
    '- ',
    '',
    '## Notes:',
    '- ',
    '',
    '',
    '────────────────────────────────────────',
    'Press <Tab> to continue to fork options',
    'Press <Esc> to cancel',
  }
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Create window
  local width = math.min(100, vim.o.columns - 10)
  local height = math.min(25, vim.o.lines - 6)
  
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Agent Mission (Step 1/2) ',
    title_pos = 'center',
  })
  
  -- Set telescope-like highlights
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:TelescopeNormal,FloatBorder:TelescopeBorder,FloatTitle:TelescopeTitle')
  
  -- Position cursor at task area
  vim.api.nvim_win_set_cursor(win, {8, 0})
  
  -- Function to extract mission from buffer
  local function get_mission()
    local all_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local mission_lines = {}
    local in_content = false
    
    for _, line in ipairs(all_lines) do
      -- Stop at the separator line
      if line:match('^────') then
        break
      end
      
      -- Skip header lines but include everything else
      if not line:match('^#') and not line:match('^Enter your detailed') and not line:match('^You can use multiple') then
        if line ~= '' or in_content then
          in_content = true
          table.insert(mission_lines, line)
        end
      end
    end
    
    -- Clean up the mission text
    local mission = table.concat(mission_lines, '\n'):gsub('^%s*(.-)%s*$', '%1')
    -- Remove placeholder text
    mission = mission:gsub('%(Type your task here%.%.%.%)', '')
    return mission
  end
  
  -- Function to proceed to fork selection
  local function proceed_to_fork_selection()
    local mission = get_mission()
    if mission == '' or mission:match('^%s*$') then
      vim.notify('Please enter a mission description', vim.log.levels.ERROR)
      return
    end
    
    -- Close current window
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    
    -- Proceed to fork selection
    local state = {
      fork_option = 1,
      mission = mission,
    }
    M.show_fork_options_ui(state)
  end
  
  local function close_window()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  
  -- Set up keymaps
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Tab>', '', {
    callback = proceed_to_fork_selection,
    silent = true,
  })
  vim.api.nvim_buf_set_keymap(buf, 'i', '<Tab>', '', {
    callback = proceed_to_fork_selection,
    silent = true,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', {
    callback = close_window,
    silent = true,
  })
  
  -- Start in insert mode at the task area
  vim.cmd('startinsert')
end

-- Show fork options UI with telescope-like styling
function M.show_fork_options_ui(state)
  local default_branch = claude.git.default_branch()
  local options = {
    { label = 'Current branch', desc = 'Fork from your current branch state', value = 1 },
    { label = default_branch .. ' branch', desc = 'Start fresh from ' .. default_branch .. ' branch', value = 2 },
    { label = 'Stash current changes', desc = 'Include your uncommitted changes', value = 3 },
    { label = 'Other branch...', desc = 'Choose any branch to fork from', value = 4 },
  }
  
  -- Create buffer for options
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  
  -- Create lines for display
  local lines = {}
  -- Handle multiline mission by showing first line only
  local mission_first_line = state.mission:match('[^\n]*') or state.mission
  local mission_preview = mission_first_line:sub(1, 60) .. (mission_first_line:len() > 60 and '...' or '')
  table.insert(lines, string.format('Mission: %s', mission_preview))
  table.insert(lines, '')
  table.insert(lines, 'Select fork option:')
  table.insert(lines, '')
  
  for i, option in ipairs(options) do
    local icon = i == state.fork_option and '▶' or ' '
    table.insert(lines, string.format('%s %d. %s', icon, i, option.label))
    table.insert(lines, string.format('   %s', option.desc))
    table.insert(lines, '')
  end
  
  table.insert(lines, 'Press Enter to create agent, q to cancel')
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  
  -- Create window with telescope-like styling
  local width = math.min(80, vim.o.columns - 10)
  local height = math.min(#lines + 4, vim.o.lines - 10)
  
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Fork Options (Step 2/2) ',
    title_pos = 'center',
  })
  
  -- Set telescope-like highlights
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:TelescopeNormal,FloatBorder:TelescopeBorder,FloatTitle:TelescopeTitle')
  
  -- Function to update the display
  local function update_display()
    local updated_lines = {}
    -- Handle multiline mission by showing first line only
    local mission_first_line = state.mission:match('[^\n]*') or state.mission
    local mission_preview = mission_first_line:sub(1, 60) .. (mission_first_line:len() > 60 and '...' or '')
    table.insert(updated_lines, string.format('Mission: %s', mission_preview))
    table.insert(updated_lines, '')
    table.insert(updated_lines, 'Select fork option:')
    table.insert(updated_lines, '')
    
    for i, option in ipairs(options) do
      local icon = i == state.fork_option and '▶' or ' '
      table.insert(updated_lines, string.format('%s %d. %s', icon, i, option.label))
      table.insert(updated_lines, string.format('   %s', option.desc))
      table.insert(updated_lines, '')
    end
    
    table.insert(updated_lines, 'Press Enter to create agent, q to cancel')
    
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, updated_lines)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  end
  
  -- Create agent with selected options
  local function create_agent()
    -- Close the window
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    
    -- Handle fork option
    local fork_from = nil
    local default_branch = claude.git.default_branch()
    if state.fork_option == 1 then
      -- Current branch (default)
      fork_from = { type = 'branch', branch = claude.git.current_branch() or default_branch }
    elseif state.fork_option == 2 then
      -- Default branch (main/master)
      fork_from = { type = 'branch', branch = default_branch }
    elseif state.fork_option == 3 then
      -- Stash current changes
      fork_from = { type = 'stash' }
    elseif state.fork_option == 4 then
      -- Other branch - show branch selection
      M.show_branch_selection(function(branch)
        if branch then
          fork_from = { type = 'branch', branch = branch }
          M.create_agent_from_task(state.mission, fork_from)
        end
      end)
      return
    end
    
    -- Create the agent
    M.create_agent_from_task(state.mission, fork_from)
  end
  
  -- Navigation functions
  local function move_up()
    if state.fork_option > 1 then
      state.fork_option = state.fork_option - 1
      update_display()
    end
  end
  
  local function move_down()
    if state.fork_option < #options then
      state.fork_option = state.fork_option + 1
      update_display()
    end
  end
  
  -- Set up keymaps
  local function close_window()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  
  -- Number keys
  for i = 1, #options do
    vim.api.nvim_buf_set_keymap(buf, 'n', tostring(i), '', {
      callback = function()
        state.fork_option = i
        update_display()
      end,
      silent = true,
    })
  end
  
  -- Navigation keys
  vim.api.nvim_buf_set_keymap(buf, 'n', 'j', '', { callback = move_down, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'k', '', { callback = move_up, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Down>', '', { callback = move_down, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Up>', '', { callback = move_up, silent = true })
  
  -- Action keys
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', { callback = create_agent, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', { callback = close_window, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', { callback = close_window, silent = true })
end

-- Show branch selection UI
function M.show_branch_selection(callback)
  -- Get list of branches
  local branches_output = claude.utils.exec('git branch -a')
  if not branches_output then
    vim.notify('Failed to get branches', vim.log.levels.ERROR)
    callback(nil)
    return
  end
  
  local branches = {}
  for line in branches_output:gmatch('[^\n]+') do
    local branch = line:match('^%s*%*?%s*(.+)$')
    if branch and not branch:match('HEAD detached') then
      -- Clean up remote branch names
      branch = branch:gsub('^remotes/origin/', '')
      table.insert(branches, branch)
    end
  end
  
  -- Remove duplicates
  local seen = {}
  local unique_branches = {}
  for _, branch in ipairs(branches) do
    if not seen[branch] then
      seen[branch] = true
      table.insert(unique_branches, branch)
    end
  end
  
  vim.ui.select(unique_branches, {
    prompt = 'Select branch to fork from:',
  }, callback)
end

-- Create agent from task and fork options
function M.create_agent_from_task(task, fork_from)
  if not claude.tmux.validate() then
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
  
  -- Handle fork options
  local success, result
  local base_info = ''
  
  if fork_from and fork_from.type == 'stash' then
    -- Create a stash first
    vim.notify('Creating stash of current changes...', vim.log.levels.INFO)
    local stash_cmd = 'git stash push -m "Agent fork: ' .. task:sub(1, 50) .. '"'
    local stash_result = claude.utils.exec(stash_cmd)
    
    if stash_result and stash_result:match('Saved working directory') then
      -- Create worktree from current branch
      local branch = claude.git.current_branch() or claude.git.default_branch()
      success, result = claude.git.create_worktree(agent_dir, branch)
      
      if success then
        -- Apply the stash in the new worktree
        local apply_cmd = string.format('cd "%s" && git stash pop', agent_dir)
        claude.utils.exec(apply_cmd)
        base_info = string.format('Forked from: %s (with stashed changes)', branch)
      end
    else
      vim.notify('No changes to stash, using current branch', vim.log.levels.INFO)
      fork_from = { type = 'branch', branch = claude.git.current_branch() or claude.git.default_branch() }
    end
  end
  
  if not success and fork_from and fork_from.type == 'branch' then
    -- Create worktree from specified branch
    success, result = claude.git.create_worktree(agent_dir, fork_from.branch)
    base_info = string.format('Forked from: %s branch', fork_from.branch)
  elseif not success then
    -- Default behavior - use current branch
    local branch = claude.git.current_branch() or claude.git.default_branch()
    success, result = claude.git.create_worktree(agent_dir, branch)
    base_info = string.format('Forked from: %s branch', branch)
  end
  
  if not success then
    vim.notify('Failed to create worktree: ' .. tostring(result), vim.log.levels.ERROR)
    return
  end
  
  -- Create mission log with fork info
  local log_content = string.format(
    "Agent Mission Log\n================\n\nTask: %s\nStarted: %s\nStatus: Active\n%s\n\n",
    task,
    os.date('%Y-%m-%d %H:%M:%S'),
    base_info
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
    -- Prepare fork info for registry
    local fork_info = {
      type = fork_from and fork_from.type or 'branch',
      branch = fork_from and fork_from.branch or (claude.git.current_branch() or claude.git.default_branch()),
      base_info = base_info
    }
    
    -- Register agent with fork info
    local agent_id = claude.registry.register(task, agent_dir, window_id, window_name, fork_info)
    
    -- Update mission log with agent ID
    local log_content = claude.utils.read_file(agent_dir .. '/mission.log')
    log_content = log_content .. string.format("\nAgent ID: %s\n", agent_id)
    claude.utils.write_file(agent_dir .. '/mission.log', log_content)
    
    -- Create progress file for agent to update
    local progress_file = agent_dir .. '/progress.txt'
    claude.utils.write_file(progress_file, 'Starting...')
    
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
        "I should work independently to complete this task.\n\n" ..
        "To report progress, update the file: %s/progress.txt\n" ..
        "Example: echo 'Analyzing codebase...' > progress.txt\n\n" ..
        "%s",
        task, agent_dir, agent_dir, base_info
      )
      claude.tmux.send_text_to_pane(pane_claude, task_msg)
    end

    vim.notify(string.format(
      'Background agent started\nID: %s\nTask: %s\nWorkspace: %s\nWindow: %s\n%s',
      agent_id,
      task,
      agent_dir,
      window_name,
      base_info
    ), vim.log.levels.INFO)
  else
    vim.notify('Failed to create agent window', vim.log.levels.ERROR)
  end
end

-- List all agents with interactive UI
function M.list_agents()
  -- Validate agents first
  claude.registry.validate_agents()
  
  local agents = claude.registry.get_project_agents()
  if vim.tbl_isempty(agents) then
    vim.notify('No agents found for this project', vim.log.levels.INFO)
    return
  end
  
  -- Sort agents by start time (newest first)
  table.sort(agents, function(a, b) return a.start_time > b.start_time end)
  
  -- Create interactive buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  
  -- Build display lines
  local lines = {}
  local agent_map = {} -- Map line numbers to agents
  
  table.insert(lines, ' Claude Agents')
  table.insert(lines, '')
  table.insert(lines, ' Keys: <Enter> switch · d diff · k kill · r refresh · q quit')
  table.insert(lines, '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  table.insert(lines, '')
  
  local start_line = #lines + 1
  for i, agent in ipairs(agents) do
    local formatted = claude.registry.format_agent(agent)
    table.insert(lines, string.format(' %d. %s', i, formatted))
    agent_map[#lines] = agent
    
    -- Add work directory info
    local dir_info = '    ' .. (agent.work_dir:match('([^/]+)/?$') or agent.work_dir)
    table.insert(lines, dir_info)
    agent_map[#lines] = agent
    
    table.insert(lines, '')
  end
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  
  -- Create window
  local width = math.max(80, math.min(120, vim.o.columns - 10))
  local height = math.min(#lines + 2, vim.o.lines - 10)
  
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Agent Manager ',
    title_pos = 'center',
  })
  
  -- Set initial cursor position
  vim.api.nvim_win_set_cursor(win, {start_line, 0})
  
  -- Helper function to get agent under cursor
  local function get_current_agent()
    local row = vim.api.nvim_win_get_cursor(win)[1]
    return agent_map[row]
  end
  
  -- Keymaps
  local function close_window()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  
  -- Enter - Switch to agent
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
    callback = function()
      local agent = get_current_agent()
      if agent then
        close_window()
        M.switch_agent(agent._registry_id)
      end
    end,
    silent = true,
  })
  
  -- d - Diff agent
  vim.api.nvim_buf_set_keymap(buf, 'n', 'd', '', {
    callback = function()
      local agent = get_current_agent()
      if agent then
        close_window()
        M.diff_agent(agent._registry_id)
      end
    end,
    silent = true,
  })
  
  -- k - Kill agent
  vim.api.nvim_buf_set_keymap(buf, 'n', 'k', '', {
    callback = function()
      local agent = get_current_agent()
      if agent and agent.status == 'active' then
        vim.ui.confirm(
          string.format('Kill agent "%s"?', agent.task:match('[^\n]*') or agent.task),
          { '&Yes', '&No' },
          function(choice)
            if choice == 1 then
              M.kill_agent(agent._registry_id)
              close_window()
              -- Reopen the list to show updated state
              vim.defer_fn(function() M.list_agents() end, 100)
            end
          end
        )
      else
        vim.notify('Agent is not active', vim.log.levels.INFO)
      end
    end,
    silent = true,
  })
  
  -- r - Refresh
  vim.api.nvim_buf_set_keymap(buf, 'n', 'r', '', {
    callback = function()
      close_window()
      M.list_agents()
    end,
    silent = true,
  })
  
  -- Number keys for quick selection
  for i = 1, math.min(9, #agents) do
    vim.api.nvim_buf_set_keymap(buf, 'n', tostring(i), '', {
      callback = function()
        close_window()
        M.switch_agent(agents[i]._registry_id)
      end,
      silent = true,
    })
  end
  
  -- Close keymaps
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', { callback = close_window, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', { callback = close_window, silent = true })
  
  -- Add highlighting
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:TelescopeNormal,FloatBorder:TelescopeBorder')
  vim.api.nvim_win_set_option(win, 'cursorline', true)
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
  -- Show cleanup options
  vim.ui.select(
    {'Clean completed agents', 'Clean agents older than ' .. claude.config.agents.cleanup_days .. ' days', 'Clean ALL inactive agents', 'Cancel'},
    {
      prompt = 'Select cleanup option:',
    },
    function(choice)
      if not choice or choice == 'Cancel' then
        return
      end
      
      local removed = 0
      
      if choice == 'Clean completed agents' then
        removed = M.cleanup_completed_agents()
      elseif choice:match('older than') then
        removed = claude.registry.cleanup(claude.config.agents.cleanup_days)
      elseif choice == 'Clean ALL inactive agents' then
        removed = M.cleanup_all_inactive_agents()
      end
      
      if removed > 0 then
        vim.notify(string.format('Cleaned up %d agent(s)', removed), vim.log.levels.INFO)
      else
        vim.notify('No agents to clean up', vim.log.levels.INFO)
      end
    end
  )
end

-- Clean up completed agents
function M.cleanup_completed_agents()
  local removed = 0
  local agents = claude.registry.get_project_agents()
  
  for _, agent in ipairs(agents) do
    if agent.status == 'completed' then
      -- Remove work directory
      if agent.work_dir and claude.utils.file_exists(agent.work_dir) then
        -- Remove git worktree properly
        claude.git.remove_worktree(agent.work_dir)
      end
      
      claude.registry.remove(agent.id)
      removed = removed + 1
    end
  end
  
  return removed
end

-- Clean up all inactive agents
function M.cleanup_all_inactive_agents()
  local removed = 0
  local agents = claude.registry.get_project_agents()
  
  for _, agent in ipairs(agents) do
    if agent.status ~= 'active' then
      -- Remove work directory
      if agent.work_dir and claude.utils.file_exists(agent.work_dir) then
        -- Remove git worktree properly
        claude.git.remove_worktree(agent.work_dir)
      end
      
      claude.registry.remove(agent.id)
      removed = removed + 1
    end
  end
  
  return removed
end

-- Clean orphaned agent directories
function M.clean_orphaned_directories()
  local work_dir = claude.utils.get_project_root() .. '/' .. claude.config.agents.work_dir
  
  if not claude.utils.file_exists(work_dir) then
    vim.notify('No agent work directory found', vim.log.levels.INFO)
    return
  end
  
  -- Get all directories in agent work dir
  local dirs = vim.fn.readdir(work_dir)
  local orphaned = {}
  
  -- Check each directory
  for _, dir in ipairs(dirs) do
    local dir_path = work_dir .. '/' .. dir
    local found = false
    
    -- Check if this directory is tracked by any agent
    local agents = claude.registry.get_project_agents()
    for _, agent in ipairs(agents) do
      if agent.work_dir == dir_path then
        found = true
        break
      end
    end
    
    if not found then
      table.insert(orphaned, dir_path)
    end
  end
  
  if #orphaned == 0 then
    vim.notify('No orphaned directories found', vim.log.levels.INFO)
    return
  end
  
  -- Confirm cleanup
  vim.ui.select(
    {'Yes - Remove ' .. #orphaned .. ' orphaned directories', 'No - Cancel'},
    {
      prompt = 'Found ' .. #orphaned .. ' orphaned agent directories. Clean them up?',
    },
    function(choice)
      if choice and choice:match('^Yes') then
        local removed = 0
        for _, dir in ipairs(orphaned) do
          claude.git.remove_worktree(dir)
          removed = removed + 1
        end
        vim.notify(string.format('Removed %d orphaned directories', removed), vim.log.levels.INFO)
      end
    end
  )
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

-- Switch to agent's worktree
function M.switch_agent(agent_id)
  -- Get agent from registry
  local agent = claude.registry.get(agent_id)
  if not agent then
    -- If no ID provided, show selection UI
    local agents = claude.registry.get_project_agents()
    if #agents == 0 then
      vim.notify('No agents found', vim.log.levels.INFO)
      return
    end
    
    -- Always show selection UI unless ID was provided
    M.show_agent_selection('switch')
    return
  end
  
  -- Check if agent is still active
  if not claude.registry.check_window_exists(agent.window_id) then
    vim.notify('Agent window no longer exists', vim.log.levels.ERROR)
    return
  end
  
  -- Check if worktree still exists
  if not claude.utils.file_exists(agent.work_dir) then
    vim.notify(string.format('Agent work directory no longer exists: %s', agent.work_dir), vim.log.levels.ERROR)
    -- Try to check if it's a directory issue
    local parent_dir = vim.fn.fnamemodify(agent.work_dir, ':h')
    if claude.utils.file_exists(parent_dir) then
      vim.notify('Parent directory exists: ' .. parent_dir, vim.log.levels.INFO)
      -- List contents to debug
      local contents = vim.fn.readdir(parent_dir)
      if contents and #contents > 0 then
        vim.notify('Contents: ' .. table.concat(contents, ', '), vim.log.levels.INFO)
      end
    end
    return
  end
  
  -- Save current session state
  vim.cmd('wall')  -- Write all buffers
  
  -- Change to agent's worktree
  vim.cmd('cd ' .. agent.work_dir)
  
  -- Background agents keep hooks disabled - no inline diffs
  -- This keeps the workflow simple and predictable
  
  -- Clear all buffers and open new nvim in the worktree
  vim.cmd('%bdelete')
  vim.cmd('edit .')
  
  -- Notify user
  vim.notify(string.format(
    'Switched to agent worktree (no inline diffs)\nTask: %s\nWindow: %s\nUse :ClaudeDiffAgent to review changes',
    agent.task,
    agent.window_name
  ), vim.log.levels.INFO)
  
  -- Also switch tmux to the agent's window
  local tmux_cmd = string.format('tmux select-window -t %s', agent.window_id)
  os.execute(tmux_cmd)
end

-- Show agent selection UI for different actions
function M.show_agent_selection(action)
  local agents = claude.registry.get_project_agents()
  
  if #agents == 0 then
    vim.notify('No active agents found', vim.log.levels.INFO)
    return
  end
  
  -- Create selection buffer
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = { 'Select agent to ' .. action .. ':', '', }
  
  for i, agent in ipairs(agents) do
    local line = string.format('%d. %s', i, claude.registry.format_agent(agent))
    table.insert(lines, line)
  end
  
  table.insert(lines, '')
  table.insert(lines, 'Press number to select, q to quit')
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  
  -- Create floating window
  local width = math.max(60, math.min(100, vim.o.columns - 10))
  local height = math.min(#lines + 2, vim.o.lines - 10)
  
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Agent Selection ',
    title_pos = 'center',
  })
  
  -- Set up keymaps for selection
  for i = 1, math.min(9, #agents) do
    vim.api.nvim_buf_set_keymap(buf, 'n', tostring(i), '', {
      silent = true,
      callback = function()
        vim.cmd('close')  -- Close selection window
        local selected_agent = agents[i]
        if selected_agent then
          if action == 'switch' then
            M.switch_agent(selected_agent.id)
          elseif action == 'diff' then
            M.diff_agent(selected_agent.id)
          end
        end
      end
    })
  end
  
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { silent = true })
end


-- Review agent changes with diffview
function M.diff_agent(agent_id)
  -- Get agent from registry
  local agent = claude.registry.get(agent_id)
  if not agent then
    -- Check if we're currently in an agent worktree
    local current_dir = vim.fn.getcwd()
    local agents = claude.registry.get_project_agents()
    
    -- Try to find agent by work directory
    for _, a in ipairs(agents) do
      if a.work_dir == current_dir then
        agent = a
        break
      end
    end
    
    if not agent then
      -- If no ID provided and not in agent dir, show selection UI
      if #agents == 0 then
        vim.notify('No agents found', vim.log.levels.INFO)
        return
      elseif #agents == 1 then
        -- Auto-select the only agent
        agent = agents[1]
      else
        -- Show selection UI for multiple agents
        M.show_agent_selection('diff')
        return
      end
    end
  end
  
  -- Check if worktree still exists
  if not claude.utils.file_exists(agent.work_dir) then
    vim.notify('Agent work directory no longer exists', vim.log.levels.ERROR)
    return
  end
  
  -- Get the base branch that the agent started from
  local base_branch = agent.fork_info and agent.fork_info.branch or (claude.git.current_branch() or claude.git.default_branch())
  
  -- Check if diffview is available
  local has_diffview = pcall(require, 'diffview')
  if not has_diffview then
    -- Fallback to fugitive
    vim.notify('Diffview not found, using fugitive', vim.log.levels.INFO)
    -- Save current directory and change to agent directory
    local original_cwd = vim.fn.getcwd()
    vim.cmd('cd ' .. agent.work_dir)
    vim.cmd('Git diff ' .. base_branch)
  else
    -- Save current directory to restore later  
    local original_cwd = vim.fn.getcwd()
    
    -- Change to the agent's worktree directory
    vim.cmd('cd ' .. agent.work_dir)
    
    -- Set up autocmd to restore directory when diffview closes
    local restore_dir_group = vim.api.nvim_create_augroup('ClaudeRestoreDir', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'DiffviewViewClosed',
      group = restore_dir_group,
      once = true,
      callback = function()
        vim.cmd('cd ' .. original_cwd)
        vim.notify('Restored to original directory: ' .. original_cwd, vim.log.levels.DEBUG)
      end
    })
    
    -- Also restore on BufWinLeave as a fallback
    vim.api.nvim_create_autocmd('BufWinLeave', {
      pattern = 'diffview://*',
      group = restore_dir_group,
      once = true,
      callback = function()
        -- Small delay to ensure diffview cleanup is complete
        vim.defer_fn(function()
          if vim.fn.getcwd() ~= original_cwd then
            vim.cmd('cd ' .. original_cwd)
            vim.notify('Restored to original directory: ' .. original_cwd, vim.log.levels.DEBUG)
          end
        end, 100)
      end
    })
    
    -- Now diffview will work in the context of the worktree
    -- First check if there are uncommitted changes
    local git_status = claude.git.status(agent.work_dir)
    local has_uncommitted = #git_status > 0
    
    if has_uncommitted then
      -- Show working directory changes (including uncommitted files)
      vim.cmd('DiffviewOpen')
      vim.notify(string.format(
        'Showing uncommitted changes in agent worktree\nTask: %s\nWorktree: %s\n\nNote: Agent has uncommitted changes. To see branch diff, commit the changes first.',
        agent.task:match('[^\n]*') or agent.task,
        agent.work_dir
      ), vim.log.levels.INFO)
    else
      -- Use triple-dot notation to compare against the merge-base
      local cmd = string.format(':DiffviewOpen %s...HEAD --imply-local', base_branch)
      vim.cmd(cmd)
      vim.notify(string.format(
        'Reviewing agent changes\nTask: %s\nComparing against: %s\nWorktree: %s\nOriginal dir: %s',
        agent.task:match('[^\n]*') or agent.task,
        base_branch,
        agent.work_dir,
        original_cwd
      ), vim.log.levels.INFO)
    end
  end
end

return M 