-- python-debugging.lua: Debugging Python code with DAP
--

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',  -- Python adapter
      'rcarriga/nvim-dap-ui',          -- UI for DAP
      'theHamsta/nvim-dap-virtual-text' -- Inline variable text
    },
    keys = {
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: Terminate' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<leader>do', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<leader>dr', function() require('dap').repl.open() end, desc = 'Debug: Open REPL' },
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      
      -- Configure dapui
      dapui.setup()
      
      -- Configure Python
      require('dap-python').setup(vim.fn.exepath('python3'))
      
      -- Auto open/close dapui
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    end
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
