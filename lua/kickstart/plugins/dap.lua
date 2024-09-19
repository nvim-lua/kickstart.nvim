return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'mxsdev/nvim-dap-vscode-js',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      local js_based_languages = { 'typescript', 'javascript', 'typescriptreact' }
      require('dap-vscode-js').setup {
        -- node_path = 'node', -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = '/home/rapzy/vscode-js-debug', -- Path to vscode-js-debug installation.
        -- debugger_cmd = { 'js-debug-adapter' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
        -- log_file_path = '/home/rapzy/.cache/dap_vscode_js.log', -- Path for file logging
        -- log_file_level = 0, -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR, -- Logging level for output to console. Set to false to disable console output.
      }

      for _, language in ipairs(js_based_languages) do
        require('dap').configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          -- {
          --   type = 'pwa-chrome',
          --   request = 'launch',
          --   name = 'Start Chrome with "localhost"',
          --   url = 'http://localhost:3000',
          --   webRoot = '${workspaceFolder}',
          --   userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir',
          -- },
        }
      end

      require('dapui').setup()

      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

      --Eval var under cursor
      -- vim.keymap.set('n', '<space>?', function()
      --   require('dapui').eval(nil, { enter = true })
      -- end)

      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F13>', dap.restart)

      --Automatically open UI when we start debugging
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
