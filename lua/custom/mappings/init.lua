-- Problems window
vim.keymap.set('n', '<leader>Co', '<Cmd>copen<CR>')
vim.keymap.set('n', '<leader>Cp', '<Cmd>cprev<CR>')
vim.keymap.set('n', '<leader>Cn', '<Cmd>cnext<CR>')

-- Select all
vim.keymap.set('n', '<C-S-a>', 'ggVG')

-- Stop deselecting after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move stuff up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- Move down/up lines but recenter
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'j', 'jzz', { noremap = true, silent = true })
vim.keymap.set('n', 'k', 'kzz', { noremap = true, silent = true })
