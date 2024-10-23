return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'SmiteshP/nvim-navbuddy',
      dependencies = {
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim',
      },
      opts = { lsp = { auto_attach = true } },
    },
  },
  -- your lsp config or other stuff
}
