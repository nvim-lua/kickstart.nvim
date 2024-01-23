-- Easy save with CTRL + s
vim.keymap.set('n', '<C-s>', ':update<cr>', { noremap = true })
vim.keymap.set({ 'i', 'v' }, '<C-s>', '<Esc>:update<cr>', { noremap = true })

-- Split Movement
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
