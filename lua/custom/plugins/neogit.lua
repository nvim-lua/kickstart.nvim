return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      {
        'sindrets/diffview.nvim', -- optional - Diff integration
        -- dependencies = {
        -- brew install font-hack-nerd-font
        -- 'nvim-tree/nvim-web-devicons',
        -- },
        config = {
          use_icons = false,
        },
      },
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
    vim.keymap.set({ 'n' }, '<leader>n', '<cmd>Neogit kind=replace<CR>', {}),
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
