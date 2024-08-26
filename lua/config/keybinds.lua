local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

keymap.set('n', '<C-a>', 'gg<S-v>G')
