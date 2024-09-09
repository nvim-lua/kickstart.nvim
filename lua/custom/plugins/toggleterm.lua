return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    {
      '<leader>tf',
      '<cmd>ToggleTerm direction=float<CR>',
      desc = 'Toggle Float Terminal',
    },
    {
      '<leader>tv',
      '<cmd>ToggleTerm direction=vertical<CR>',
      desc = 'Toggle Vertcal Terminal',
    },
    {
      '<leader>th',
      '<cmd>ToggleTerm direction=horizontal<CR>',
      desc = 'Toggle Horizontal Terminal',
    },
  },
}
