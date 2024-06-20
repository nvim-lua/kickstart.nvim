return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
      theme = 'hyper',
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
