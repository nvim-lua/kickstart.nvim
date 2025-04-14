-- Custom Keybinds.

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'escape' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'escape' })

-- Перемещение между буферами
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>')

vim.keymap.set('n', ',,', '<Cmd>ToggleTerm<CR>', { desc = 'Open terminal in horizontal split' })
vim.keymap.set('t', ',,', '<Cmd>ToggleTerm<CR>', { desc = 'Open terminal in horizontal split' })

-- Закрыть буфер
vim.keymap.set('n', '<C-q>', '<Cmd>bdelete<CR>')

-- Переход к буферу по номеру (например, Alt+1, Alt+2...)
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>')
end
