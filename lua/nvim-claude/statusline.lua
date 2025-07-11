-- Statusline components for nvim-claude
local M = {}

-- Get active agent count and summary
function M.get_agent_status()
  local registry = require('nvim-claude.registry')
  
  -- Validate agents to update their status
  registry.validate_agents()
  
  local agents = registry.get_project_agents()
  local active_count = 0
  local latest_progress = nil
  local latest_task = nil
  
  for _, agent in ipairs(agents) do
    if agent.status == 'active' then
      active_count = active_count + 1
      -- Get the most recently updated active agent
      if not latest_progress or (agent.last_update and agent.last_update > (latest_progress.last_update or 0)) then
        latest_progress = agent.progress
        latest_task = agent.task
      end
    end
  end
  
  if active_count == 0 then
    return ''
  elseif active_count == 1 and latest_progress then
    -- Show single agent progress
    local task_short = latest_task
    if #latest_task > 20 then
      task_short = latest_task:sub(1, 17) .. '...'
    end
    return string.format('🤖 %s: %s', task_short, latest_progress)
  else
    -- Show count of multiple agents
    return string.format('🤖 %d agents', active_count)
  end
end

-- Lualine component
function M.lualine_component()
  return {
    M.get_agent_status,
    cond = function()
      -- Only show if there are active agents
      local status = M.get_agent_status()
      return status ~= ''
    end,
    on_click = function()
      -- Open agent list on click
      vim.cmd('ClaudeAgents')
    end,
  }
end

-- Simple string function for custom statuslines
function M.statusline()
  local status = M.get_agent_status()
  if status ~= '' then
    return ' ' .. status .. ' '
  end
  return ''
end

return M