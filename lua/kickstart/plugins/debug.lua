-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Create a beutifull debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim dap ui
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    -- Install the debug adapter for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Add your own debugger here
    'mfussenegger/nvim-dap-python',
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function() require('dap').continue() end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function() require('dap').step_into() end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function() require('dap').step_over() end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function() require('dap').step_out() end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function() require('dap').toggle_breakpoint() end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function() require('dapui').toggle() end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    require('dapui').setup()
    require('dap-go').setup()

    require('mason-nvim-dap').setup {
      automatic_instalation = true,

      handlers = {},

      ensure_installed = {
        'delve',
        'python',
      },
    }

    require('nvim-dap-virtual-text').setup {
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then return '*****' end

        if #variable.value > 15 then return ' ' .. string.sub(variable.value, 1, 15) .. '... ' end

        return ' ' .. variable.value
      end,
    }

    -- Handled by nvim-dap-go
    -- dap.adapters.go = {
    --   type = "server",
    --   port = "${port}",
    --   executable = {
    --     command = "dlv",
    --     args = { "dap", "-l", "127.0.0.1:${port}" },
    --   },
    -- }

    local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
    if elixir_ls_debugger ~= '' then
      dap.adapters.mix_task = {
        type = 'executable',
        command = elixir_ls_debugger,
      }

      dap.configurations.elixir = {
        {
          type = 'mix_task',
          name = 'phoenix server',
          task = 'phx.server',
          request = 'launch',
          projectDir = '${workspaceFolder}',
          exitAfterTaskReturns = false,
          debugAutoInterpretAllModules = false,
        },
      }
    end

    -- CodeLLDB debug adapter location
    local codelldb = vim.fn.expand '$MASON/packages/codelldb'
    local extension_path = codelldb .. '/extension/'
    local codelldb_path = extension_path .. 'adapter/codelldb'

    -- Configure the LLDB adapter
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
      enrich_config = function(config, on_config)
        -- If the configuration(s) in `launch.json` contains a `cargo` section
        -- send the configuration off to the cargo_inspector.
        if config['cargo'] ~= nil then on_config(cargo_inspector(config)) end
      end,
    }

    -- Configure LLDB adapter
    dap.adapters.lldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
        detached = false,
      },
    }

    -- Default debug configuration for C, C++
    dap.configurations.c = {
      {
        name = 'Debug an Executable',
        type = 'lldb',
        request = 'launch',
        program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = {
      {
        name = 'Debug an Executable',
        type = 'lldb',
        request = 'launch',
        program = function()
          local cwd = vim.fn.getcwd()
          local default_binary = cwd .. '/target/debug/' .. vim.fn.fnamemodify(cwd, ':t')
          return vim.fn.input('Path to executable: ', default_binary, 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    -- Override default configurations with `launch.json`
    require('dap.ext.vscode').load_launchjs('.nvim/launch.json', { lldb = { 'c', 'cpp', 'rust' } })

    vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

    -- Eval var under cursor
    vim.keymap.set('n', '<space>?', function() require('dapui').eval(nil, { enter = true }) end)

    vim.keymap.set('n', '<F1>', dap.continue)
    vim.keymap.set('n', '<F2>', dap.step_into)
    vim.keymap.set('n', '<F3>', dap.step_over)
    vim.keymap.set('n', '<F4>', dap.step_out)
    vim.keymap.set('n', '<F5>', dap.step_back)
    vim.keymap.set('n', '<F13>', dap.restart)

    dap.listeners.before.attach.dapui_config = function() ui.open() end
    dap.listeners.before.launch.dapui_config = function() ui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
    dap.listeners.before.event_exited.dapui_config = function() ui.close() end

    require('dap-python').setup()
  end,
}
