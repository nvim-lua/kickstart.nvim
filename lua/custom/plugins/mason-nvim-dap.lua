return {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'mfussenegger/nvim-dap',
  },
  config = function()
    require('mason-nvim-dap').setup {
      ensure_installed = { 'codelldb' },
      automatic_installation = true,
      handlers = {},
    }
  end,
}
