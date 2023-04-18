-- Keymaps

local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<C-PageDown>', ':BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<C-PageUp>', ':BufferLineCyclePrev<CR>', opts)
vim.keymap.set('n', '<leader>]', ':BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<leader>[', ':BufferLineCycleNext<CR>', opts)

vim.keymap.set('n', '<C-S-PageDown>', ':BufferLineMoveNext<CR>', opts)
vim.keymap.set('n', '<C-S-PageUp>', ':BufferLineMovePrev<CR>', opts)
vim.keymap.set('n', '<leader>}', ':BufferLineMoveNext<CR>', opts)
vim.keymap.set('n', '<leader>{', ':BufferLineMovePrev<CR>', opts)

for i = 1, 9, 1 do
    vim.keymap.set('n', '<leader>' .. i, '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>', opts)
end
vim.keymap.set('n', '<leader>$', '<cmd>BufferLineGoToBuffer -1<CR>', opts)
