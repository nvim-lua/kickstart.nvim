return {
  'deparr/tairiki.nvim',
  lazy = false,
  priority = 1000, -- only necessary if you use tairiki as default theme
  config = function()
    require('tairiki').setup {
      style = 'dark',
    }
  end,
}
