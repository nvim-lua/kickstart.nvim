return {
  'sindrets/diffview.nvim',
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
    { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Diffview Close' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
}
