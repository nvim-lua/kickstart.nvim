-- vim.keymap.set('n', '!', '_') -- For macos only

-- Center the view when moving
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Access to file viewer easily
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject files [V]iewer' })

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

-- Undotree
vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle)
