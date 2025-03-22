return { -- Virtual Environment Selector
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      name = {
        'venv',
        '.venv',
        'env',
        '.env',
      },
    },
    keys = {
      -- Keymap to open venv selector
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select VirtualEnv' },
    },
  },
}
