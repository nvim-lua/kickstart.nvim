require('mini.git').setup()

vim.keymap.set('n', '<leader>ga', '<cmd>Git add -A<CR>', { desc = 'Git add all' })
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gs', '<cmd>Git status<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gg', '<cmd>Git log --graph --oneline --all<CR>', { desc = 'Git graph' })

require('mini.move').setup()
-- usage: Alt = directional keys should move the line in normal mode
