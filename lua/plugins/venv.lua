return {
  'linux-cultist/venv-selector.nvim', 
  branch = 'regexp',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python',
    'nvim-telescope/telescope.nvim',
  },
  lazy = false,
  config = function()
    require('venv-selector').setup()
  end,
  keys = {
    { ',v', '<cmd>VenvSelect<cr>' },
  },
}
