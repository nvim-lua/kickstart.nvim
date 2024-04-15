return {
  'akinsho/toggleterm.nvim',
  version = '*',
  init = function()
    -- Toggleterm Plugin
    vim.keymap.set('n', '<leader>tt', '<Cmd>1ToggleTerm name="floater" direction="float"<CR>', { desc = '[T]oggle [T]erminal' })
  end,
  config = true,
}
