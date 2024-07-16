return {
  {
    'NeogitOrg/neogit',
    version = 'v0.0.1', -- Only working version right now as dev is backlogged
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    keys = {
      { '<leader>ng', ':Neogit cwd=%:p:h<CR>', desc = 'Open neogit repository for current buffer' },
    },
    config = function()
      require('neogit').setup {
        integrations = {
          diffview = true,
          telescope = true,
        },
      }
    end,
  },
}
