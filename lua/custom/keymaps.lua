--
-- Additional keymaps
--

local wk = require('which-key')

-- Quality of life
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { noremap = true, silent = true, desc = '[W]rite Buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { noremap = true, silent = true, desc = '[Q]uit Buffer' })

-- basic navigation
wk.register({
  ['<leader>d'] = { name = '[D]o <C-w>', _ = 'which_key_ignore' },
})
vim.keymap.set('n', '<leader>dh', '<C-w>h', { noremap = true, silent = true, desc = 'move to left window' })
vim.keymap.set('n', '<leader>dj', '<C-w>j', { noremap = true, silent = true, desc = 'move to bottom window' })
vim.keymap.set('n', '<leader>dk', '<C-w>k', { noremap = true, silent = true, desc = 'move to top window' })
vim.keymap.set('n', '<leader>dl', '<C-w>l', { noremap = true, silent = true, desc = 'move to right window' })
vim.keymap.set('n', '<leader>ds', '<C-w>s', { noremap = true, silent = true, desc = 'split window horizontally' })
vim.keymap.set('n', '<leader>dv', '<C-w>v', { noremap = true, silent = true, desc = 'split window vertically' })
vim.keymap.set('n', '<leader>dc', '<C-w>c', { noremap = true, silent = true, desc = 'close window' })
vim.keymap.set('n', '<leader>dq', '<C-w>q', { noremap = true, silent = true, desc = 'quit window' })
vim.keymap.set('n', '<leader>do', '<C-w>o', { noremap = true, silent = true, desc = 'close all other windows' })
vim.keymap.set('n', '<leader>dw', '<C-w>w', { noremap = true, silent = true, desc = 'move to next window' })
vim.keymap.set('n', '<leader>d+', '<C-w>+', { noremap = true, silent = true, desc = 'increase window height' })
vim.keymap.set('n', '<leader>d-', '<C-w>-', { noremap = true, silent = true, desc = 'decrease window height' })
vim.keymap.set('n', '<leader>d>', '<C-w>>', { noremap = true, silent = true, desc = 'increase window width' })
vim.keymap.set('n', '<leader>d<', '<C-w><', { noremap = true, silent = true, desc = 'decrease window width' })
vim.keymap.set('n', '<leader>d=', '<C-w>=', { noremap = true, silent = true, desc = 'balance window sizes' })

-- Turn off highlight when pressing Esc
vim.keymap.set('n', '<Esc>', '<cmd>noh <CR>', { noremap = false, silent = true })

-- fugitive
vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>', { desc = 'fugitive' })

-- magical base64 encoding/decoding
vim.keymap.set('n', '<M-e>', 'viWy:let @"=system("openssl base64 -A", @")<cr>gv""P', { noremap = true, silent = true })
vim.keymap.set('n', '<M-d>', 'viWy:let @"=system("openssl base64 -A -d", @")<cr>gv""P', { noremap = true, silent = true })

-- Center next/previous search
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })
