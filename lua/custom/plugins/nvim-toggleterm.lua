function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup {}
  end,
  vim.keymap.set('n', '<leader>tt', '<Cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' }),
  vim.keymap.set('n', '<leader>t2', '<Cmd>2ToggleTerm<CR>', { desc = 'Toggle terminal 2' }),
  vim.keymap.set('n', '<leader>t3', '<Cmd>3ToggleTerm<CR>', { desc = 'Toggle terminal 3' }),
  vim.keymap.set('n', '<leader>t4', '<Cmd>4ToggleTerm<CR>', { desc = 'Toggle terminal 4' }),
  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
}
