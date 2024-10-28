return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'williamboman/mason.nvim', -- for installing netcoredbg
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Setup DAP UI
      dapui.setup()
      require('nvim-dap-virtual-text').setup()

      -- CoreCLR Adapter Configuration for .NET
      dap.adapters.coreclr = {
        type = 'executable',
        command = '/usr/local/bin/netcoredbg/netcoredbg',
        args = { '--interpreter=vscode' },
      }

      -- DAP Configuration for .NET Core
      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'Launch .NET Core Web API',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/linux-x64/MelodyFitnessApi.dll', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
        },
        {
          type = 'coreclr',
          name = 'Attach to .NET Core',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }

      -- Key mappings for debugging
      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<F10>', dap.step_over)
      vim.keymap.set('n', '<F11>', dap.step_into)
      vim.keymap.set('n', '<F12>', dap.step_out)
      vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end)

      -- Automatically open/close DAP UI on start/end
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
