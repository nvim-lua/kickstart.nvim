local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Open verticle split' })
vim.keymap.set('n', '<leader>sh', '<C-w>h', { desc = 'Open horizontal split' })
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
