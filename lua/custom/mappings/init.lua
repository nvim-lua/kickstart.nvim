-- Problems window
vim.keymap.set('n', '<leader>Co', '<Cmd>copen<CR>')
vim.keymap.set('n', '<leader>Cp', '<Cmd>cprev<CR>')
vim.keymap.set('n', '<leader>Cn', '<Cmd>cnext<CR>')

-- Select all
vim.keymap.set('n', '<C-S-a>', 'ggVG')

-- Stop deselecting after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
