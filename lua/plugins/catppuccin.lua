return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  flavour = 'frappe',
  init = function()
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
