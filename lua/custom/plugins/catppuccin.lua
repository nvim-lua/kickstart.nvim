return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {},
  config = function()
    require('catppuccin').setup {}
    vim.cmd.colorscheme 'catppuccin-macchiato'
    vim.o.cursorline = true
    vim.wo.signcolumn = 'auto'
    vim.opt.termguicolors = true
  end,
}
