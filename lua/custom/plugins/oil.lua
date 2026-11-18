return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>e', '<CMD>Oil<CR>', desc = 'Open folder structure with Oil' },
    },
    opts = {
      default_file_explorer = true,
    },
  },
}
