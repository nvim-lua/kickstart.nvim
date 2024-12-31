-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>q', '<cmd>confirm q<cr>', { desc = 'Quit File' })

vim.keymap.set('v', '<C-c>', '"*y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<leader>p', [["_dP]], { desc = 'Paste and retain paste in clipboard' })
vim.keymap.set('n', '<leader>sr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and Replace Highlighted Word' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep cusor in index position on J' })

-- Keep cusor in middle of buffer
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = '⬇ middle of buffer and keep cusor in middle of buffer' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = '⬆ middle of buffer and keep cusor in middle of buffer' })
vim.keymap.set('n', 'N', 'nzzzv', { desc = 'next search and keep cusor in middle of buffer' })
vim.keymap.set('n', 'n', 'Nzzzv', { desc = 'previous search and keep cusor in middle of buffer' })

-- Move highlighted up or down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted down' })

-- Map <leader>c to close and save the buffer
vim.api.nvim_set_keymap('n', '<leader>c', [[:w | bd<CR>]], { noremap = true, silent = true })
