return {
  {
    'NeogitOrg/neogit',
    version = 'v0.0.1', -- Version required for nvim 0.9.5
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
        integrations = {
          diffview = true,
          telescope = true,
        },
      }
    end,
  },
}
