-- Where am I?
vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>cD', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Moving between windows
vim.cmd.tnoremap('<A-h>', [[<C-\><C-N><C-w>h]])
vim.cmd.tnoremap('<A-j>', [[<C-\><C-N><C-w>j]])
vim.cmd.tnoremap('<A-k>', [[<C-\><C-N><C-w>k]])
vim.cmd.tnoremap('<A-l>', [[<C-\><C-N><C-w>l]])
vim.cmd.inoremap('<A-h>', [[<C-\><C-N><C-w>h]])
vim.cmd.inoremap('<A-j>', [[<C-\><C-N><C-w>j]])
vim.cmd.inoremap('<A-k>', [[<C-\><C-N><C-w>k]])
vim.cmd.inoremap('<A-l>', [[<C-\><C-N><C-w>l]])
vim.cmd.nnoremap('<A-h>', [[<C-w>h]])
vim.cmd.nnoremap('<A-j>', [[<C-w>j]])
vim.cmd.nnoremap('<A-k>', [[<C-w>k]])
vim.cmd.nnoremap('<A-l>', [[<C-w>l]])
