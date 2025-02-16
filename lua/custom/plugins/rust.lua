return {
  -- {
  --   'rust-lang/rust.vim',
  --   ft = 'rust',
  --   init = function()
  --     vim.g.rustfmt_autosave = 1
  --   end,
  -- },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
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
  -- {
  --   'cordx56/rustowl',
  --   dependencies = { 'neovim/nvim-lspconfig' },
  --   -- config = function()
  --   --   local lspconfig = require 'lspconfig'
  --   --   lspconfig.rustowlsp.setup {}
  --   -- end,
  -- },
}
