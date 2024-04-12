return {
  'akinsho/toggleterm.nvim',
  version = '*',
  init = function()
    -- Toggleterm Plugin
    vim.keymap.set('n', '<leader>t', '<Cmd>1ToggleTerm name="floater" direction="float"<CR>', { desc = '[T]oggle [T]erminal' })
    vim.keymap.set('n', '<leader>tt', '<Cmd>2ToggleTerm name="horizont" direction="horizontal"<CR>', { desc = '[T]oggle [T]erminal' })
    vim.keymap.set('n', '<leader>tl', '<Cmd>TermSelect<CR>', { desc = '[T]oggle [T]erminal' })
  end,
  config = true,
}
