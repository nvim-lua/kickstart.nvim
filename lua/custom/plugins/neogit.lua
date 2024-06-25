return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      {
        'sindrets/diffview.nvim', -- optional - Diff integration
        dependencies = {
          'nvim-web-devicons',
        },
      },

      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
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
}
