return {
  'mfussenegger/nvim-dap',
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
    require('dapui').setup()
    require('dap-go').setup()

    local dap, dapui = require 'dap', require 'dapui'

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<Leader>db', ':DapToggleBreakpoint<CR>')
    vim.keymap.set('n', '<Leader>dc', ':DapContinue<CR>')
    vim.keymap.set('n', '<Leader>dx', ':DapTerminate<CR>')
    vim.keymap.set('n', '<Leader>do', ':DapStepOver<CR>')
  end,
}
