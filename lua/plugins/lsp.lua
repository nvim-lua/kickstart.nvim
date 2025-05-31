return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- LSP Support
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },

    { 'rafamadriz/friendly-snippets' },
  },
  -- Use the lazy option to lazy-load the plugin on events or commands
  lazy = true,
}
