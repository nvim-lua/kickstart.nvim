return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'float', -- Opens a floating terminal
      shell = vim.o.shell, -- Uses the default shell
    }
    -- Keymap to open terminal with Ctrl+/
    vim.keymap.set('n', '<C-y>', '<Cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })
    vim.keymap.set('t', '<C-y>', '<Cmd>ToggleTerm<CR>', { noremap = true, silent = true })
  end,
}
