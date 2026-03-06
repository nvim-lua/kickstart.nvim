return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewFileHistory',
    'DiffviewFocusFiles',
    'DiffviewToggleFiles',
    'DiffviewRefresh',
  },
  keys = {
    { '<leader>Gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iff view' },
    { '<leader>GD', '<cmd>DiffviewClose<CR>', desc = '[G]it [D]iff close' },
    { '<leader>Gf', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it [F]ile history' },
    { '<leader>GF', '<cmd>DiffviewFileHistory<CR>', desc = '[G]it [F]ull history' },
  },
  opts = {},
}
