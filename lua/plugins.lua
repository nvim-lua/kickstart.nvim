return {
  { 'folke/tokyonight.nvim' },
  { "nvim-lua/popup.nvim" },   -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins
  { "windwp/nvim-autopairs" }, -- Autopairs
  -- "numToStr/Comment.nvim" -- Easily comment stuff
  { 'kyazdani42/nvim-web-devicons' },
  -- Colorschemes
  -- "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  { "lunarvim/darkplus.nvim" },
  { "moll/vim-bbye" },

  -- snippets
  { "L3MON4D3/LuaSnip" },             --snippet engine
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

  -- Telescope
  { "nvim-telescope/telescope-media-files.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  --  "p00f/nvim-ts-rainbow"
  --  "nvim-treesitter/playground"
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
      "hrsh7th/nvim-cmp",
      dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip',
          'hrsh7th/cmp-vsnip',
          'hrsh7th/vim-vsnip',
          'rafamadriz/friendly-snippets',
      }
  },
  { 'mfussenegger/nvim-lint', },
  { 'mfussenegger/nvim-dap' },
  { 'mhartington/formatter.nvim' }
}
