-- Keymaps

local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<C-PageDown>', ':BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<C-PageUp>', ':BufferLineCyclePrev<CR>', opts)
vim.keymap.set('n', ']b', ':BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', opts)

vim.keymap.set('n', '<C-S-PageDown>', ':BufferLineMoveNext<CR>', opts)
vim.keymap.set('n', '<C-S-PageUp>', ':BufferLineMovePrev<CR>', opts)

vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin<CR>', opts)
vim.keymap.set('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>',
    { silent = true, noremap = true, desc = 'Delete non-pinned buffers' })

for i = 1, 9, 1 do
    vim.keymap.set('n', '<leader>' .. i, '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>', opts)
end
vim.keymap.set('n', '<leader>$', '<cmd>BufferLineGoToBuffer -1<CR>', opts)
