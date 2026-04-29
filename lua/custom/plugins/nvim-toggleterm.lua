return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  -- opts = {--[[ things you want to change go here]] },
  keys = {
    { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'ToggleTerm' },
    { '<C-\\><C-\\>', '<cmd>ToggleTerm<cr>', mode = 'n', desc = 'ToggleTerm' },
    { '<C-\\><C-\\>', '<C-\\><C-n><cmd>ToggleTerm<cr>', mode = 't', desc = 'ToggleTerm' },
    { '<C-`>', '<cmd>ToggleTerm<cr>', mode = 'n', desc = 'ToggleTerm' },
    { '<C-`>', '<C-\\><C-n><cmd>ToggleTerm<cr>', mode = 't', desc = 'ToggleTerm' },
    -- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    -- vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  },
}
