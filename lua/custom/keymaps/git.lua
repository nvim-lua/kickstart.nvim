-- Git-related keymaps

-- LazyGit
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Open LazyGit' })
vim.keymap.set('n', '<leader>gc', ':LazyGitCurrentFile<CR>', { desc = 'LazyGit current file' })
vim.keymap.set('n', '<leader>gf', ':LazyGitFilter<CR>', { desc = 'LazyGit filter' })
