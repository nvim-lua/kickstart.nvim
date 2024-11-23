vim.g.mapleader = ' '

local keymap = vim.keymap

keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' }) -- increment
keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- window management
keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' }) -- split window vertically
keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' }) -- split window horizontally
keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close current split' }) -- close current split window

keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' }) -- open new tab
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' }) --  go to next tab
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' }) --  go to previous tab
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab
keymap.set('n', '<leader>sf', ':w<CR>', { desc = 'Save current file' }) --  move current buffer to new tab
keymap.set('n', '<leader>sa', ':wa<CR>', { desc = 'Save all file' }) --  move current buffer to new tab
