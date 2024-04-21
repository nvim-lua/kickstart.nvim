return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    {
      '<leader>to',
      '<Cmd>ToggleTerm<CR>',
      desc = '[O]pen a horizontal terminal',
    },
    {
      '<A-i>',
      '<Cmd>ToggleTermToggle<CR>',
    },
    {
      '<leader>tt',
      '<Cmd>ToggleTermToggle<CR>',
      desc = '[T]oggle terminals',
    },
  },
}
