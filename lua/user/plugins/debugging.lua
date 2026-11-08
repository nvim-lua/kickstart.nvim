return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    dap.adapters.armgdb = {
      type = 'executable',
      command = 'arm-none-eabi-gdb',
      args = { '-i', 'dap', '-q', '-ex', 'target remote 127.0.0.1:3333' },
    }
    dap.configurations.c = {
      {
        name = 'Launch',
        type = 'armgdb',
        request = 'launch',
        -- program = "${workspaceFolder}/Debug/Medido3_V2.elf",
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
    }
    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue <F5>' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into <F11>' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over <F10>' })
    vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step Out <F9>' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
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

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Toggle debug Gui' })
    vim.keymap.set('n', '<leader>td', dapui.toggle, { desc = 'Toggle debug Gui' })
    vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = 'Toggle debug Gui' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
