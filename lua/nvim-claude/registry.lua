-- Agent registry module for nvim-claude
local M = {}
local utils = require('nvim-claude.utils')

-- Registry data
M.agents = {}
M.registry_path = nil

-- Initialize registry
function M.setup(config)
  -- Set up registry directory
  local data_dir = vim.fn.stdpath('data') .. '/nvim-claude'
  utils.ensure_dir(data_dir)
  
  M.registry_path = data_dir .. '/registry.json'
  
  -- Load existing registry
  M.load()
end

-- Load registry from disk
function M.load()
  vim.notify('registry.load() called', vim.log.levels.DEBUG)
  local content = utils.read_file(M.registry_path)
  if content then
    vim.notify(string.format('registry.load: Read %d bytes from %s', #content, M.registry_path), vim.log.levels.DEBUG)
    local ok, data = pcall(vim.json.decode, content)
    if ok and type(data) == 'table' then
      local agent_count = vim.tbl_count(data)
      vim.notify(string.format('registry.load: Decoded %d agents from JSON', agent_count), vim.log.levels.DEBUG)
      M.agents = data
      M.validate_agents()
    else
      vim.notify('registry.load: Failed to decode JSON, clearing agents', vim.log.levels.WARN)
      M.agents = {}
    end
  else
    vim.notify('registry.load: No content read from file, clearing agents', vim.log.levels.WARN)
    M.agents = {}
  end
end

-- Save registry to disk
function M.save()
  if not M.registry_path then return false end
  
  local content = vim.json.encode(M.agents)
  return utils.write_file(M.registry_path, content)
end

-- Validate agents (remove stale entries)
function M.validate_agents()
  local valid_agents = {}
  local now = os.time()
  
  
  for id, agent in pairs(M.agents) do
    -- Check if agent directory still exists
    local mission_log_path = agent.work_dir .. '/mission.log'
    local mission_exists = utils.file_exists(mission_log_path)
    
    
    if mission_exists then
      -- Check if tmux window still exists
      local window_exists = M.check_window_exists(agent.window_id)
      
      if window_exists then
        agent.status = 'active'
        
        -- Update progress from file for active agents
        local progress_file = agent.work_dir .. '/progress.txt'
        local progress_content = utils.read_file(progress_file)
        if progress_content and progress_content ~= '' then
          agent.progress = progress_content:gsub('\n$', '')  -- Remove trailing newline
        end
        
        valid_agents[id] = agent
      else
        -- Window closed, mark as completed
        agent.status = 'completed'
        agent.end_time = agent.end_time or now
        valid_agents[id] = agent
      end
    end
  end
  
  M.agents = valid_agents
  M.save()
end

-- Check if tmux window exists
function M.check_window_exists(window_id)
  if not window_id then return false end
  
  local cmd = string.format("tmux list-windows -F '#{window_id}' | grep -q '^%s$'", window_id)
  local result = os.execute(cmd)
  return result == 0
end

-- Register a new agent
function M.register(task, work_dir, window_id, window_name, fork_info)
  local id = utils.timestamp() .. '-' .. math.random(1000, 9999)
  local agent = {
    id = id,
    task = task,
    work_dir = work_dir,
    window_id = window_id,
    window_name = window_name,
    start_time = os.time(),
    status = 'active',
    project_root = utils.get_project_root(),
    progress = 'Starting...',  -- Add progress field
    last_update = os.time(),
    fork_info = fork_info,  -- Store branch/stash info
  }
  
  M.agents[id] = agent
  M.save()
  
  return id
end

-- Get agent by ID
function M.get(id)
  return M.agents[id]
end

-- Get all agents for current project
function M.get_project_agents()
  -- Ensure registry is loaded
  if not M.agents or vim.tbl_isempty(M.agents) then
    M.load()
  end
  
  local project_root = utils.get_project_root()
  local project_agents = {}
  
  for id, agent in pairs(M.agents) do
    if agent.project_root == project_root then
      -- Include the registry ID with the agent
      agent._registry_id = id
      table.insert(project_agents, agent)
    end
  end
  
  return project_agents
end

-- Get active agents count
function M.get_active_count()
  local count = 0
  for _, agent in pairs(M.agents) do
    if agent.status == 'active' then
      count = count + 1
    end
  end
  return count
end

-- Update agent status
function M.update_status(id, status)
  if M.agents[id] then
    M.agents[id].status = status
    if status == 'completed' or status == 'failed' then
      M.agents[id].end_time = os.time()
    end
    M.agents[id].last_update = os.time()
    M.save()
  end
end

-- Update agent progress
function M.update_progress(id, progress)
  if M.agents[id] then
    M.agents[id].progress = progress
    M.agents[id].last_update = os.time()
    M.save()
  end
end

-- Remove agent
function M.remove(id)
  M.agents[id] = nil
  M.save()
end

-- Clean up old agents
function M.cleanup(days)
  if not days or days < 0 then return end
  
  local cutoff = os.time() - (days * 24 * 60 * 60)
  local removed = 0
  
  for id, agent in pairs(M.agents) do
    if agent.status ~= 'active' and agent.end_time and agent.end_time < cutoff then
      -- Remove work directory
      if agent.work_dir and utils.file_exists(agent.work_dir) then
        local cmd = string.format('rm -rf "%s"', agent.work_dir)
        utils.exec(cmd)
      end
      
      M.agents[id] = nil
      removed = removed + 1
    end
  end
  
  if removed > 0 then
    M.save()
  end
  
  return removed
end

-- Format agent for display
function M.format_agent(agent)
  local age = os.difftime(os.time(), agent.start_time)
  local age_str
  
  if age < 60 then
    age_str = string.format('%ds', age)
  elseif age < 3600 then
    age_str = string.format('%dm', math.floor(age / 60))
  elseif age < 86400 then
    age_str = string.format('%dh', math.floor(age / 3600))
  else
    age_str = string.format('%dd', math.floor(age / 86400))
  end
  
  local progress_str = ''
  if agent.progress and agent.status == 'active' then
    progress_str = string.format(' | %s', agent.progress)
  end
  
  -- Clean up task to single line
  local task_line = agent.task:match('[^\n]*') or agent.task
  local task_preview = task_line:sub(1, 50) .. (task_line:len() > 50 and '...' or '')
  
  return string.format(
    '[%s] %s (%s) - %s%s',
    agent.status:upper(),
    task_preview,
    age_str,
    agent.window_name or 'unknown',
    progress_str
  )
end

return M