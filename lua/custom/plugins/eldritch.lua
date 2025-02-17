return {
  'eldritch-theme/eldritch.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd [[colorscheme eldritch]]
  end,
}
