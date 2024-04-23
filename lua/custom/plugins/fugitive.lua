return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gg', ':Git<CR>')
    vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
    vim.keymap.set('n', '<leader>gP', ':Git pull<CR>')
    vim.keymap.set('n', '<leader>gh', ':0Gclog<CR>')
    vim.keymap.set('n', '<leader>gd', ':Git difftool<CR>')
    vim.keymap.set('n', '<leader>gs', ':Gvdiffsplit<CR>')
    vim.keymap.set('n', '<leader>gx', ':Git mergetool<CR>')
  end,
}
