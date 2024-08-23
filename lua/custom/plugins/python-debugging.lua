-- python-debugging.lua: Debugging Python code with DAP
--

return {
  -- DEBUGGING

  -- DAP Client for nvim
  -- - start the debugger with `<leader>dc`
  -- - add breakpoints with `<leader>db`
  -- - terminate the debugger `<leader>dt`
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Start/Continue Debugger',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Add Breakpoint',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate Debugger',
      },
    },
  },

  -- UI for the debugger
  -- - the debugger UI is also automatically opened when starting/stopping the debugger
  -- - toggle debugger UI manually with `<leader>du`
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = 'Toggle Debugger UI',
      },
    },
    -- automatically open/close the DAP UI when starting/stopping the debugger
    config = function()
      local listener = require('dap').listeners
      listener.after.event_initialized['dapui_config'] = function()
        require('dapui').open()
      end
      listener.before.event_terminated['dapui_config'] = function()
        require('dapui').close()
      end
      listener.before.event_exited['dapui_config'] = function()
        require('dapui').close()
      end
    end,
  },

  -- Configuration for the python debugger
  -- - configures debugpy for us
  -- - uses the debugpy installation from mason
  {
    'mfussenegger/nvim-dap-python',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      -- fix: E5108: Error executing lua .../Local/nvim-data/lazy/nvim-dap-ui/lua/dapui/controls.lua:14: attempt to index local 'element' (a nil value)
      -- see: https://github.com/rcarriga/nvim-dap-ui/issues/279#issuecomment-1596258077
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup()
      -- uses the debugypy installation by mason
      local debugpyPythonPath = require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/bin/python3'
      require('dap-python').setup(debugpyPythonPath, {}) ---@diagnostic disable-line: missing-fields
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
