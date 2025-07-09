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
  local content = utils.read_file(M.registry_path)
  if content then
    local ok, data = pcall(vim.json.decode, content)
    if ok and type(data) == 'table' then
      M.agents = data
      M.validate_agents()
    else
      M.agents = {}
    end
  else
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
    if utils.file_exists(agent.work_dir .. '/mission.log') then
      -- Check if tmux window still exists
      local window_exists = M.check_window_exists(agent.window_id)
      
      if window_exists then
        agent.status = 'active'
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
function M.register(task, work_dir, window_id, window_name)
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
  local project_root = utils.get_project_root()
  local project_agents = {}
  
  for id, agent in pairs(M.agents) do
    if agent.project_root == project_root then
      project_agents[id] = agent
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
  
  return string.format(
    '[%s] %s (%s) - %s',
    agent.status:upper(),
    agent.task,
    age_str,
    agent.window_name or 'unknown'
  )
end

return M