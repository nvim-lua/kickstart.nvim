-- Debug Keymaps Configuration
local M = {}

function M.setup()
  local dap = require('dap')
  local dapui = require('dapui')
  
  -- Function key mappings for common debug operations
  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
  
  -- Breakpoint management
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>dB', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Conditional Breakpoint' })
  vim.keymap.set('n', '<leader>lp', function()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
  end, { desc = 'Debug: Set Log Point' })
  
  -- DAP UI controls
  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle UI' })
  vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Debug: Eval under cursor' })
  vim.keymap.set('v', '<leader>de', dapui.eval, { desc = 'Debug: Eval selection' })
  
  -- REPL and additional features
  vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
  vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
  
  -- Widget-based inspections
  vim.keymap.set('n', '<leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = 'Debug: Hover Variables' })
  
  vim.keymap.set('n', '<leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, { desc = 'Debug: View Scopes' })
  
  vim.keymap.set('n', '<leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end, { desc = 'Debug: View Frames' })
  
  -- Session management
  vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug: Terminate Session' })
  vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'Debug: Continue to Cursor' })
  
  -- Create visual indicators for breakpoints
  vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '⭕', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'DapLogPoint', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '▶️', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
end

return M