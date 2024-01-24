-- Easy save with CTRL + s
vim.keymap.set('n', '<C-s>', ':update<cr>', { noremap = true })
vim.keymap.set({ 'i', 'v' }, '<C-s>', '<Esc>:update<cr>', { noremap = true })

-- Split Movement
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Jump and keep cursor in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keep searchterms in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Paste over visually selected maintaining clipboard
vim.keymap.set('x', '<leader>p', [["_dP]])
