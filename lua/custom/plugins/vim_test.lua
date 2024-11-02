return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  setup = {
    vim.cmd 'let test#strategy = "vimux"',
  },
  keys = {
    { '<leader>tt', '<cmd>TestFile<CR>', { desc = 'Test file' } },
    { '<leader>tn', '<cmd>TestNearest<CR>', { desc = 'Test nearest' } },
    { '<leader>tl', '<cmd>TestLast<CR>', { desc = 'Test last' } },
  },
}
