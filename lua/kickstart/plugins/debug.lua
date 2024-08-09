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
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information

      handlers = nil,

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'codelldb',
        'js-debug-adapter',
      },
    }

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
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    -- cpp
    dap.adapters.cpp = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.exepath 'codelldb',
        args = { '--port', '${port}' },
      },
    }
    dap.configurations.cpp = {
      {
        name = 'LLDB: Launch',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        console = 'integratedTerminal',
      },
    }

    -- rust
    dap.configurations.rust = dap.configurations.cpp

    -- c
    dap.configurations.c = dap.configurations.cpp

    -- js/ts
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- 💀 Make sure to update this path to point to your installation
        args = { vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }
    dap.configurations.javascript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
    }

    dap.configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
    }

    -- debug our applications running on the browser.
    --note: chrome has to be started with a remote debugging port INFO : google-chrome-stable --remote-debugging-port=9222
    -- dap.adapters.chrome = {
    --   type = 'executable',
    --   command = 'node',
    --   args = { vim.fn.stdpath 'data' .. '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js' }, -- TODO adjust
    -- }
    --
    -- dap.configurations.javascriptreact = { -- change this to javascript if needed
    --   {
    --     type = 'chrome',
    --     request = 'attach',
    --     program = '${file}',
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     port = 9230,
    --     webRoot = '${workspaceFolder}',
    --   },
    -- }
    --
    -- dap.configurations.typescriptreact = { -- change to typescript if needed
    --   {
    --     type = 'chrome',
    --     request = 'attach',
    --     program = '${file}',
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     port = 9230,
    --     webRoot = '${workspaceFolder}',
    --   },
    -- }
    -- dap.configurations.javascriptreact = {
    --   {
    --     type = 'pwa-node',
    --     request = 'launch',
    --     name = 'Launch Next.js',
    --     runtimeExecutable = 'pnpm',
    --     runtimeArgs = { 'run', 'dev' },
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     -- console = 'integratedTerminal',
    --     port = 9230,
    --     -- skipFiles = { '<node_internals>/**', 'node_modules/**/*.js' },
    --   },
    --   {
    --     type = 'pwa-node',
    --     request = 'attach',
    --     name = 'Attach to Next.js',
    --     processId = require('dap.utils').pick_process,
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     -- console = 'integratedTerminal',
    --     port = 9230,
    --   },
    -- }
    --
    -- dap.configurations.typescriptreact = dap.configurations.javascriptreact
    -- virtual text
    require('nvim-dap-virtual-text').setup {
      -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
          return '*****'
        end

        if #variable.value > 15 then
          return ' ' .. string.sub(variable.value, 1, 15) .. '... '
        end

        return ' ' .. variable.value
      end,
    }
  end,
}
