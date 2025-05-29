return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 999,
  config = function()
    vim.o.background = 'dark' -- or 'light'
    vim.cmd.colorscheme 'solarized'
  end,
}
