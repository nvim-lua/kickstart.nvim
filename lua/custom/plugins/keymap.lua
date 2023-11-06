vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', { desc = 'Write file' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window right' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window up' })

vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })

vim.keymap.set('n', '<leader>c', '<Cmd>q<CR>', { desc = 'Move right' })

vim.keymap.set('n', '<A-j>', ":m .+1<CR>==")
vim.keymap.set('n', '<A-k>', ":m .-2<CR>==")

vim.keymap.set('i', '<A-k>', "<Esc>:m .-2<CR>==gi")
vim.keymap.set('i', '<A-j>', "<Esc>:m .+1<CR>==gi")

vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv-gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv-gv")

vim.keymap.set('n', 'J', "mzJ`z")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', "\"_dP")


return {}
