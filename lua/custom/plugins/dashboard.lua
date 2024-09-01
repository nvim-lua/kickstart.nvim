-- https://github.com/nvimdev/dashboard-nvim
return {
  'nvimdev/dashboard-nvim',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  event = 'VimEnter',
  opts = {},
  config = function(_, opts)
    require('dashboard').setup(opts)
  end,
}
