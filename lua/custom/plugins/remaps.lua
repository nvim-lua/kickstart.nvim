return {
  vim.keymap.set('n', '<C-d>', '<C-d>zz'), -- Center after half-page down
  vim.keymap.set('n', '<C-u>', '<C-u>zz'), -- Center after half-page up
  vim.keymap.set('n', 'n', 'nzzzv'), -- Center after next result
  vim.keymap.set('n', 'N', 'Nzzzv'), -- Center after previous result
  vim.keymap.set('x', '<leader>p', [["_dP]]), -- Paste without losing register
  vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]]), -- Yank to OS clipboard
  vim.keymap.set('n', '<leader>Y', [["+Y]]), -- ????
  vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]]), -- ????
  vim.keymap.set('n', '<leader>cm', vim.cmd.ZenMode, { desc = '[Z]en [M]ode' }), -- Toggle ZenMode
}
