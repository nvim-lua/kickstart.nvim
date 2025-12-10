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

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',

    'wojciech-kulik/xcodebuild.nvim',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<leader>ee',
      function()
        require('xcodebuild.integrations.dap').build_and_debug()
      end,
      desc = 'Build & Debug',
    },
    {
      '<leader>dr',
      function()
        require('xcodebuild.integrations.dap').debug_without_build()
      end,
      desc = 'Debug Without Building',
    },
    {
      '<leader>dt',
      function()
        require('xcodebuild.integrations.dap').debug_tests()
      end,
      desc = 'Debug Tests',
    },
    {
      '<leader>dT',
      function()
        require('xcodebuild.integrations.dap').debug_class_tests()
      end,
      desc = 'Debug Class Tests',
    },
    {
      '<leader>b',
      function()
        require('xcodebuild.integrations.dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('xcodebuild.integrations.dap').toggle_message_breakpoint()
      end,
      desc = 'Toggle Message Breakpoint',
    },
    {
      '<leader>dx',
      function()
        require('xcodebuild.integrations.dap').terminate_session()
      end,
      desc = 'Terminate Debugger',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    local xcodebuild = require 'xcodebuild.integrations.dap'

    xcodebuild.setup()

    local function setupListeners()
      local dap = require 'dap'
      local areSet = false

      dap.listeners.after['event_initialized']['me'] = function()
        if not areSet then
          areSet = true
          vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue', noremap = true })
          vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, { desc = 'Run To Cursor' })
          vim.keymap.set('n', '<leader>ds', dap.step_over, { desc = 'Step Over' })
          vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
          vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Step Out' })
          vim.keymap.set({ 'n', 'v' }, '<Leader>dh', require('dap.ui.widgets').hover, { desc = 'Hover' })
          vim.keymap.set({ 'n', 'v' }, '<Leader>de', require('dapui').eval, { desc = 'Eval' })
        end
      end

      dap.listeners.after['event_terminated']['me'] = function()
        if areSet then
          areSet = false
          vim.keymap.del('n', '<leader>dc')
          vim.keymap.del('n', '<leader>dC')
          vim.keymap.del('n', '<leader>ds')
          vim.keymap.del('n', '<leader>di')
          vim.keymap.del('n', '<leader>do')
          vim.keymap.del({ 'n', 'v' }, '<Leader>dh')
          vim.keymap.del({ 'n', 'v' }, '<Leader>de')
        end
      end
    end
    setupListeners()
    require('dap').defaults.fallback.switchbuf = 'usetab,uselast'
    vim.keymap.set('n', '<leader>dx', function()
      xcodebuild.terminate_session()
      require('dap').listeners.after['event_terminated']['me']()
    end, { desc = 'Terminate debugger' })

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
        'delve',
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

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

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
  end,
}
