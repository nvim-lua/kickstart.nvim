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
    'nvim-telescope/telescope-dap.nvim',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

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

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = "DAP: Launch/Continue" })
    vim.keymap.set('n', '<F6>', dap.terminate, { desc = "DAP: Terminate" })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = "DAP: Step into" })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = "DAP: Step over" })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = "DAP: Step out" })
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set('n', '<leader>bc', function()
      dap.clear_breakpoints()
      require("notify")("Breakpoints cleared", "warn")
    end, { desc = "DAP: Clear Breakpoints" })
    vim.keymap.set('n', '<leader>bB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = "DAP: Toggle Breakpoint (cond)" })

    local telescope = require('telescope')
    telescope.load_extension('dap')
    vim.keymap.set('n', '<leader>sb',
      telescope.extensions.dap.list_breakpoints,
      { desc = 'DAP: [S]earch [B]reakpoints' })
    vim.keymap.set('n', '<leader>sv',
      telescope.extensions.dap.variables,
      { desc = 'DAP: [S]earch [V]ariables' })
    vim.keymap.set('n', '<leader>sF',
      telescope.extensions.dap.frames,
      { desc = 'DAP: [S]earch [F]rames' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
    -- Install python specific config
    require('dap-python').setup()
    -- Setup additional adapter/configuration definitions
    require('custom.dap')
  end,
}
