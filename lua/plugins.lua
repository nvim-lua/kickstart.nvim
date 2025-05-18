return {
  { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim 
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins
  { "windwp/nvim-autopairs" }, -- Autopairs
  -- "numToStr/Comment.nvim" -- Easily comment stuff
  { 'kyazdani42/nvim-web-devicons' },
  -- Colorschemes
  -- "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  { "lunarvim/darkplus.nvim" },
  { "akinsho/bufferline.nvim" },
  { "moll/vim-bbye" },
-- cmp plugins
  { "hrsh7th/nvim-cmp" }, -- The completion plugin
  { "hrsh7th/cmp-buffer" }, -- buffer completions
  { "hrsh7th/cmp-path" }, -- path completions
  { "hrsh7th/cmp-cmdline" }, -- cmdline completions
  { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp" },

-- snippets
  { "L3MON4D3/LuaSnip" }, --snippet engine
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

-- LSP
  { "neovim/nvim-lspconfig" }, -- enable LSP
  { "williamboman/mason.nvim" }, -- simple to use language server installer
  { "williamboman/mason-lspconfig.nvim" }, -- simple to use language server installer

-- Telescope
  { "nvim-telescope/telescope-media-files.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  --  "p00f/nvim-ts-rainbow"
  --  "nvim-treesitter/playground"
}
