-- Debug Configuration (DAP)
local M = {}

function M.setup()
  local dap = require('dap')
  local dapui = require('dapui')
  
  -- Setup DAP UI with icons and controls
  dapui.setup({
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  })
  
  -- Automatically open/close DAP UI on debug events
  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
  
  -- Configure debug adapters for different languages
  require('plugins.config.debug.adapters').setup()
  
  -- Setup debug keymaps
  require('plugins.config.debug.keymaps').setup()
end

return M