-- Custom Keybinds.

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'escape' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'escape' })

-- Перемещение между буферами
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>')

-- Закрыть буфер
vim.keymap.set('n', '<leader>bd', '<Cmd>Bdelete!<CR>')

-- Переход к буферу по номеру (например, Alt+1, Alt+2...)
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>')
end
