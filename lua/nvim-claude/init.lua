-- nvim-claude: Claude integration for Neovim with tmux workflow
local M = {}

-- Default configuration
M.config = {
  tmux = {
    split_direction = 'h',  -- horizontal split
    split_size = 40,        -- 40% width
    session_prefix = 'claude-',
    pane_title = 'claude-chat',
  },
  agents = {
    work_dir = '.agent-work',
    use_worktrees = true,
    auto_gitignore = true,
    max_agents = 5,
    cleanup_days = 7,
  },
  ui = {
    float_diff = true,
    telescope_preview = true,
    status_line = true,
  },
  mappings = {
    prefix = '<leader>c',
    quick_prefix = '<C-c>',
  },
}

-- Validate configuration
local function validate_config(config)
  local ok = true
  local errors = {}
  
  -- Validate tmux settings
  if config.tmux then
    if config.tmux.split_direction and 
       config.tmux.split_direction ~= 'h' and 
       config.tmux.split_direction ~= 'v' then
      table.insert(errors, "tmux.split_direction must be 'h' or 'v'")
      ok = false
    end
    
    if config.tmux.split_size and 
       (type(config.tmux.split_size) ~= 'number' or 
        config.tmux.split_size < 1 or 
        config.tmux.split_size > 99) then
      table.insert(errors, "tmux.split_size must be a number between 1 and 99")
      ok = false
    end
  end
  
  -- Validate agent settings
  if config.agents then
    if config.agents.max_agents and 
       (type(config.agents.max_agents) ~= 'number' or 
        config.agents.max_agents < 1) then
      table.insert(errors, "agents.max_agents must be a positive number")
      ok = false
    end
    
    if config.agents.cleanup_days and 
       (type(config.agents.cleanup_days) ~= 'number' or 
        config.agents.cleanup_days < 0) then
      table.insert(errors, "agents.cleanup_days must be a non-negative number")
      ok = false
    end
    
    if config.agents.work_dir and 
       (type(config.agents.work_dir) ~= 'string' or 
        config.agents.work_dir:match('^/') or
        config.agents.work_dir:match('%.%.')) then
      table.insert(errors, "agents.work_dir must be a relative path without '..'")
      ok = false
    end
  end
  
  -- Validate mappings
  if config.mappings then
    if config.mappings.prefix and 
       type(config.mappings.prefix) ~= 'string' then
      table.insert(errors, "mappings.prefix must be a string")
      ok = false
    end
  end
  
  return ok, errors
end

-- Merge user config with defaults
local function merge_config(user_config)
  local merged = vim.tbl_deep_extend('force', M.config, user_config or {})
  
  -- Validate the merged config
  local ok, errors = validate_config(merged)
  if not ok then
    vim.notify('nvim-claude: Configuration errors:', vim.log.levels.ERROR)
    for _, err in ipairs(errors) do
      vim.notify('  - ' .. err, vim.log.levels.ERROR)
    end
    vim.notify('Using default configuration', vim.log.levels.WARN)
    return M.config
  end
  
  return merged
end

-- Plugin setup
function M.setup(user_config)
  M.config = merge_config(user_config)
  
  -- Load submodules
  M.tmux = require('nvim-claude.tmux')
  M.git = require('nvim-claude.git')
  M.utils = require('nvim-claude.utils')
  M.commands = require('nvim-claude.commands')
  M.registry = require('nvim-claude.registry')
  
  -- Initialize submodules with config
  M.tmux.setup(M.config.tmux)
  M.git.setup(M.config.agents)
  M.registry.setup(M.config.agents)
  
  -- Set up commands
  M.commands.setup(M)
  
  -- Set up keymappings if enabled
  if M.config.mappings then
    require('nvim-claude.mappings').setup(M.config.mappings, M.commands)
  end
  
  vim.notify('nvim-claude loaded', vim.log.levels.INFO)
end

return M 