return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup()
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { noremap = true, silent = true, desc = 'Toggle Oil' })
  end,
}
