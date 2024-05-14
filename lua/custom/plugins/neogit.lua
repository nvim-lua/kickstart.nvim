return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>ng', ':Neogit cwd=%:p:h<CR>', desc = 'Open neogit repository for current buffer' },
    },
    config = function()
      require('neogit').setup {
        kind = 'split',
        integrations = { diffview = true },
      }
    end,
  },
}
