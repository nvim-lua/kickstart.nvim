-- Keymaps

local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin<CR>', opts)
vim.keymap.set('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>',
    { silent = true, noremap = true, desc = 'Delete non-pinned buffers' })
