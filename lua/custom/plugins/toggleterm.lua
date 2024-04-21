return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  init = function()
    local opts = { buffer = 0 }
    --vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end,
  keys = {
    {
      '<leader>to',
      '<Cmd>ToggleTerm<CR>',
      desc = '[O]pen a horizontal terminal',
    },
    {
      '<A-i>',
      '<Cmd>ToggleTerm<CR>',
      mode = { 'n', 't' },
    },
    {
      '<leader>tt',
      '<Cmd>ToggleTermToggle<CR>',
      desc = '[T]oggle terminals',
    },
  },
}
