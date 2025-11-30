-- Terminal and code execution keymaps

-- ToggleTerm keybindings
-- Note: <c-\> is already mapped in toggleterm config for opening terminal
vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal' })
vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', { desc = 'Toggle horizontal terminal' })
vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', { desc = 'Toggle vertical terminal' })

-- Terminal mode mappings to escape easily
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', 'jj', '<C-\\><C-n>', { desc = 'Exit terminal mode with jj' })
