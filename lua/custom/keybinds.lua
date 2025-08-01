return {
  vim.keymap.set('n', '<leader>bd', ':bdelete!<CR>', { desc = '[B]uffer [D]elete' }),
  vim.keymap.set('n', '<leader>bc', ':close<CR>', { desc = '[B]uffer [C]lose' }),

  -- Open Neotree
  vim.keymap.set('n', '<leader>nt', ':Neotree<CR>', { desc = '[N]eo[T]ree' }),

  -- Cycle through tabs
  vim.keymap.set('n', 'tn', ':tabNext<CR>', { desc = '[T]ab[N]ext' }),

  -- Open Git status in Telescope
  vim.keymap.set('n', '<leader>gs', ':Telescope git_status<CR>', { desc = '[G]it [S]tatus' }),

  vim.keymap.set('n', '<leader>wsh', ':split<CR>', { desc = '[S]plit [H]orizontally' }),
  vim.keymap.set('n', '<leader>wsv', ':vsplit<CR>', { desc = '[S]plit [V]ertically' }),

  vim.keymap.set('n', '<leader>hB', ':G blame<CR>'),
}
