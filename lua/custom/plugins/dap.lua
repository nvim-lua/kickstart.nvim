return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('dap-go').setup()
      require('nvim-dap-virtual-text').setup {}

      -- Configuration for .NET Core (ASP.NET Core) using net8.0
      dap.adapters.coreclr = {
        type = 'executable',
        command = '/usr/local/bin/netcoredbg/netcoredbg', -- Update with the correct path to netcoredbg
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'Launch ASP.NET Core',
          request = 'launch',
          preLaunchTask = function()
            -- Run the project before launching the debugger
            local build_cmd = 'dotnet publish --configuration Debug --runtime linux-x64 --self-contained'
            print('Running: ' .. build_cmd)
            vim.fn.system(build_cmd)
          end,
          program = function()
            local cwd = vim.fn.getcwd()
            local dll = vim.fn.glob(cwd .. '/bin/Debug/net8.0/linux-x64/MelodyFitnessApi.dll', 0, 1)
            if #dll == 0 then
              print 'No DLL found in bin/Debug/net8.0/linux-x64'
              return ''
            end
            print('Using program: ' .. dll[1])
            return dll[1]
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
          console = 'integratedTerminal',
        },
        {
          type = 'coreclr',
          name = 'Attach ASP.NET Core',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }

      -- Configuration for Ionic Angular (JavaScript/TypeScript) using Firefox
      dap.adapters.chrome = {
        type = 'executable',
        command = 'node',
        args = { os.getenv 'HOME' .. '/.vscode/extensions/vscode-chrome-debug/out/src/chromeDebug.js' },
      }
      dap.configurations.javascript = {
        {
          type = 'chrome',
          name = 'Attach to Chrome (Ionic App)',
          request = 'attach',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          port = 9222, -- Port where Chrome is listening
          url = 'https://localhost:8100/login', -- URL of your running Ionic app
          webRoot = '${workspaceFolder}',
          timeout = 20000, -- Optional: Increase if you experience timeouts
          address = '0.0.0.0',
        },
      }

      dap.configurations.typescript = dap.configurations.javascript

      vim.keymap.set('n', '<space>tb', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F12>', dap.restart)

      -- Key mapping to toggle the DAP UI
      vim.keymap.set('n', '<Leader>dui', function()
        ui.toggle()
      end)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
