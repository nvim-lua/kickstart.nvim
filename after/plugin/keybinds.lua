-- Move between windows with arrows
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keep cursor centered when PgUp & PgDown
vim.keymap.set({ 'n', 'i', 'v' }, '<PageUp>', '<PageUp>zz', { desc = 'Page up' })
vim.keymap.set({ 'n', 'i', 'v' }, '<PageDown>', '<PageDown>zz', { desc = 'Page down' })

-- Redirect command output and allow edit
vim.keymap.set('c', '<S-CR>', function()
  require('noice').redirect(vim.fn.getcmdline())
end, { desc = 'Redirect Cmdline' })
