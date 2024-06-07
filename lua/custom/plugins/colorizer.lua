return {
  'NvChad/nvim-colorizer.lua',
  event = 'UIEnter',
  config = function()
    require('colorizer').setup {}
  end,
}
