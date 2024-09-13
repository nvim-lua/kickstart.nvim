vim.keymap.set('n', '<leader>l', ':set hlsearch!<CR>', { noremap = true, silent = true, desc = 'Toggle highlight search' })

-- Map Ctrl-s to save the file in normal and insert mode
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })

vim.keymap.set('v', '<C-c', ':OSCYankVisual<CR>', { noremap = true, silent = true })

-- Map Ctrl-c to Esc in normal mode
--vim.keymap.set('n', '<C-c>', '<Esc>', { noremap = true, silent = true })

-- Toggle comment
vim.keymap.set('n', '<C-\\>', '<plug>NERDCommenterToggle', { noremap = true, silent = true })
vim.keymap.set('v', '<C-\\>', '<plug>NERDCommenterToggle', { noremap = true, silent = true })
