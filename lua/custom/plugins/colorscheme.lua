return {
  'datsfilipe/min-theme.nvim',
  priority = 1000,
  config = function()
    require('min-theme').setup {
      theme = 'dark',
    }
    vim.cmd.colorscheme 'min-theme'
  end,
}
