-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',

  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'microsoft/vscode-js-debug',
    'mxsdev/nvim-dap-vscode-js',
    'julianolf/nvim-dap-lldb',
    'vadimcn/codelldb',
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.adapters.lldb = {
      type = 'server',
      command = vim.fn.expand('$HOME/.local/share/nvim/mason/bin/codelldb'),
      host = '127.0.0.1',
      port = 13000,
    }

    dap.configurations.cpp = {
      {
        name = 'Launch Editor (Development)',
        type = 'lldb',
        request = 'launch',
        program = '/home/wil/dev/ue5/Engine/Binaries/Linux/UnrealEditor',
        preLaunchTask = 'Editor Linux Development Build',
        args = {
          '/home/wil/dev/sro/game/SRO.uproject',
          '--port ${port}',
        },
        -- terminal = 'integrated',
        cwd = '/home/wil/dev/ue5',
        -- visualizerFile = '/home/wil/dev/ue5/Engine/Extras/VisualStudioDebugging/Unreal.natvis',
        -- showDisplayString = 'true',
      },
    }

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
        'js',
        'node2',
        'cppdbg',
        'python',
        'javadbg',
        'javatest',
      },
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end
      }
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = '[DAP] Continue' })
    vim.keymap.set('n', '<F1>', dap.step_over, { desc = '[DAP] Over' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = '[DAP] Into' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = '[DAP] Out' })
    vim.keymap.set('n', '<F6>', dap.toggle_breakpoint, { desc = '[DAP] Breakpoint toggle' })
    vim.keymap.set('n', '<F7>', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[DAP] Conditional Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
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
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.defaults.fallback.exception_breakpoints = { 'Notice', 'Warning', 'Error', 'Exception' }

    -- Install golang specific config
    require('dap-go').setup()

    -- Install javascript specific config
    require("dap-vscode-js").setup {
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      debugger_cmd = { "js-debug-adapter" },
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    }


    for _, jsLang in ipairs({ 'typescript', 'javascript' }) do
      require("dap").configurations[jsLang] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require 'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          -- trace = true, -- include debugger info
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        {
          name = 'Debug Main Process (Electron)',
          type = 'pwa-node',
          request = 'launch',
          program = '${workspaceFolder}/node_modules/.bin/electron',
          args = {
            '${workspaceFolder}/dist/index.js',
          },
          outFiles = {
            '${workspaceFolder}/dist/*.js',
          },
          resolveSourceMapLocations = {
            '${workspaceFolder}/dist/**/*.js',
            '${workspaceFolder}/dist/*.js',
          },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
        {
          name = 'Compile & Debug Main Process (Electron)',
          type = custom_adapter,
          request = 'launch',
          preLaunchTask = 'npm run build-ts',
          program = '${workspaceFolder}/node_modules/.bin/electron',
          args = {
            '${workspaceFolder}/dist/index.js',
          },
          outFiles = {
            '${workspaceFolder}/dist/*.js',
          },
          resolveSourceMapLocations = {
            '${workspaceFolder}/dist/**/*.js',
            '${workspaceFolder}/dist/*.js',
          },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
      }
    end
  end,
}
