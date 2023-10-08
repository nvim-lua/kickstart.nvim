return {
  'catppuccin/nvim',
  name = 'catppuccin',
  config = function()
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
  priority = 1000,
}
