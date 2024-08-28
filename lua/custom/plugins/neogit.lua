return {
  {
    'NeogitOrg/neogit',
    tag = 'v0.0.1',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
  },
}
