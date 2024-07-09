return {
  'christoomey/vim-tmux-navigator',
  vim.keymap.set('n', 'C-h', ':TmuxNavigatorLeft<CR>'),
  vim.keymap.set('n', 'C-j', ':TmuxNavigatorDown<CR>'),
  vim.keymap.set('n', 'C-k', ':TmuxNavigatorUp<CR>'),
  vim.keymap.set('n', 'C-l', ':TmuxNavigatorRight<CR>'),
}
