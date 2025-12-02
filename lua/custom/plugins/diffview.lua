return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView: Open' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'DiffView: File History' },
  },
}
