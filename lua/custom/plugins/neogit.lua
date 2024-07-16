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
        opts = {
          use_icons = false,
        },
      },
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
    vim.keymap.set({ 'n' }, '<leader>n', '<cmd>Neogit kind=replace<CR>', {}),
  },
}
