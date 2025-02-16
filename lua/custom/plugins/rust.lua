return {
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  --{
  --	"simrat39/rust-tools.nvim",
  --	ft = "rust",
  --	dependencies = "neovim/nvim-lspconfig",
  --	opts = function()
  --		return require "custom.configs.rust-tools"
  --	end,
  --	config = function(_, opts)
  --		require("rust-tools").setup(opts)
  --	end,
  --},
  {
    'saecki/crates.nvim',
    ft = { 'rust', 'toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function(_, opts)
      local crates = require 'crates'
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    'cordx56/rustowl',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
}
