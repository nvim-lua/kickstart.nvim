-- Mode Manager Plugin
local M = {}

-- Enhanced mode state management
M.state = {
  current_mode = 'act',     -- 'act' or 'plan'
  callbacks = {},           -- Store mode change callbacks
  history = {},            -- Track mode changes
  settings = {             -- Mode-specific settings store
    act = {},
    plan = {},
  },
  contexts = {             -- Context preservation
    act = {},
    plan = {},
  },
  hooks = {                -- Mode initialization hooks
    pre_change = {},       -- Hooks to run before mode change
    post_change = {},      -- Hooks to run after mode change
    init = {},            -- Mode initialization hooks
  }
}

-- State validation schema
local state_schema = {
  required_fields = {'current_mode', 'settings', 'contexts'},
  valid_modes = {'act', 'plan'},
  settings_required = {'act', 'plan'},
}

-- Validate state
local function validate_state()
  local errors = {}
  
  -- Check required fields
  for _, field in ipairs(state_schema.required_fields) do
    if not M.state[field] then
      table.insert(errors, string.format("Missing required field: %s", field))
    end
  end
  
  -- Validate current mode
  if not vim.tbl_contains(state_schema.valid_modes, M.state.current_mode) then
    table.insert(errors, string.format("Invalid mode: %s", M.state.current_mode))
  end
  
  -- Validate settings structure
  for _, mode in ipairs(state_schema.settings_required) do
    if not M.state.settings[mode] then
      table.insert(errors, string.format("Missing settings for mode: %s", mode))
    end
  end
  
  return #errors == 0, errors
end

-- Register a pre-change hook
function M.register_pre_hook(hook)
  table.insert(M.state.hooks.pre_change, hook)
end

-- Register a post-change hook
function M.register_post_hook(hook)
  table.insert(M.state.hooks.post_change, hook)
end

-- Register a mode initialization hook
function M.register_init_hook(hook)
  table.insert(M.state.hooks.init, hook)
end

-- Execute hooks
local function execute_hooks(hooks, ...)
  for _, hook in ipairs(hooks) do
    local success, err = pcall(hook, ...)
    if not success then
      vim.notify(string.format("Hook execution failed: %s", err), vim.log.levels.ERROR)
    end
  end
end

-- Save context for current mode
local function save_context()
  local current = M.state.current_mode
  M.state.contexts[current] = {
    buffers = vim.fn.getbufinfo({buflisted = 1}),
    window = vim.fn.winsaveview(),
    cursor = vim.api.nvim_win_get_cursor(0),
    folding = vim.fn.getwinvar(0, '&foldenable') and vim.fn.getwinvar(0, '&foldmethod'),
  }
end

-- Restore context for new mode
local function restore_context(mode)
  local ctx = M.state.contexts[mode]
  if ctx then
    -- Restore window view
    if ctx.window then
      vim.fn.winrestview(ctx.window)
    end
    -- Restore cursor position
    if ctx.cursor then
      vim.api.nvim_win_set_cursor(0, ctx.cursor)
    end
    -- Restore folding
    if ctx.folding then
      vim.wo.foldenable = true
      vim.wo.foldmethod = ctx.folding
    end
  end
end

-- Get or set mode-specific setting
function M.setting(mode, key, value)
  if not M.state.settings[mode] then
    M.state.settings[mode] = {}
  end
  if value ~= nil then
    M.state.settings[mode][key] = value
  end
  return M.state.settings[mode][key]
end

-- Register a callback to be called on mode change
function M.on_mode_change(callback)
  table.insert(M.state.callbacks, callback)
end

-- Function to execute all registered callbacks
local function execute_callbacks(old_mode, new_mode)
  for _, callback in ipairs(M.state.callbacks) do
    pcall(callback, old_mode, new_mode)
  end
end

-- Function to add mode change to history
local function log_mode_change(old_mode, new_mode)
  table.insert(M.state.history, {
    from = old_mode,
    to = new_mode,
    timestamp = os.time(),
  })
end

-- Function to toggle between Plan and Act modes
function M.toggle_mode()
  local old_mode = M.state.current_mode
  
  -- Execute pre-change hooks
  execute_hooks(M.state.hooks.pre_change, old_mode)
  
  -- Save current context
  save_context()
  
  -- Switch mode
  M.state.current_mode = old_mode == 'act' and 'plan' or 'act'
  
  -- Validate state after mode change
  local valid, errors = validate_state()
  if not valid then
    vim.notify("Mode state validation failed: " .. table.concat(errors, ", "), vim.log.levels.ERROR)
    -- Revert mode change on validation failure
    M.state.current_mode = old_mode
    return
  end
  
  -- Restore context for new mode
  restore_context(M.state.current_mode)
  
  -- Log mode change
  log_mode_change(old_mode, M.state.current_mode)
  
  -- Execute callbacks
  execute_callbacks(old_mode, M.state.current_mode)
  
  -- Execute post-change hooks
  execute_hooks(M.state.hooks.post_change, M.state.current_mode)
  
  -- Show notification of mode change
  vim.notify('Switched to ' .. M.state.current_mode:upper() .. ' mode', vim.log.levels.INFO)
  
  -- Save state to a file
  M.save_state()
  
  -- Trigger status line update
  vim.cmd('redrawstatus')
end

-- Function to get current mode
function M.get_mode()
  return M.state.current_mode:upper()
end

-- Function to get mode highlight color
function M.get_mode_highlight()
  return M.state.current_mode == 'act' and '#98c379' or '#61afef' -- Green for Act, Blue for Plan
end

-- Function to save state to file
function M.save_state()
  local state_file = vim.fn.stdpath('data') .. '/mode_state.json'
  local file = io.open(state_file, 'w')
  if file then
    -- Prepare state for persistence
    local persist_state = {
      current_mode = M.state.current_mode,
      settings = M.state.settings,
      contexts = M.state.contexts,
      last_updated = os.time(),
      version = '1.0' -- Added versioning
    }
    file:write(vim.fn.json_encode(persist_state))
    file:close()
  end
end

-- Function to load state from file
function M.load_state()
  local state_file = vim.fn.stdpath('data') .. '/mode_state.json'
  local file = io.open(state_file, 'r')
  if file then
    local content = file:read('*all')
    file:close()
    if content and content ~= '' then
      local decoded = vim.fn.json_decode(content)
      if decoded then
        -- Restore state with validation
        if decoded.version == '1.0' then
          M.state.current_mode = decoded.current_mode
          M.state.settings = decoded.settings or {act = {}, plan = {}}
          M.state.contexts = decoded.contexts or {act = {}, plan = {}}
        else
          -- Handle older versions or invalid state
          M.state.current_mode = decoded.current_mode or 'act'
          M.state.settings = {act = {}, plan = {}}
          M.state.contexts = {act = {}, plan = {}}
        end
        
        -- Validate loaded state
        local valid, errors = validate_state()
        if not valid then
          vim.notify("Loaded state validation failed: " .. table.concat(errors, ", "), vim.log.levels.WARN)
          -- Reset to default state
          M.state.current_mode = 'act'
          M.state.settings = {act = {}, plan = {}}
          M.state.contexts = {act = {}, plan = {}}
        end
      end
    end
  end
end

-- Initialize the plugin
function M.setup()
  -- Load saved state
  M.load_state()
  
  -- Execute initialization hooks
  execute_hooks(M.state.hooks.init)
  
  -- Add keybinding for mode toggle
  vim.keymap.set('n', '<leader>tm', function()
    M.toggle_mode()
  end, { desc = '[T]oggle [M]ode (Plan/Act)' })

  -- Register default callback for logging
  M.on_mode_change(function(old_mode, new_mode)
    vim.api.nvim_exec_autocmds('User', {
      pattern = 'ModeChanged',
      data = { old_mode = old_mode, new_mode = new_mode }
    })
  end)
end

-- Get mode history
function M.get_history()
  return M.state.history
end

-- Clear mode history
function M.clear_history()
  M.state.history = {}
end

return M