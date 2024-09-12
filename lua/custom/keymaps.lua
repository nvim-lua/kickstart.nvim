-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>l', ':set hlsearch!<CR>', { noremap = true, silent = true, desc = 'Toggle highlight search' })

-- Map Ctrl-s to save the file in normal and insert mode
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })

-- Map Ctrl-c to yank (copy) the selected text in visual mode
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
