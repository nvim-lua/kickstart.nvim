-- Surround text objects easily
return {
  'kylechui/nvim-surround',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {}
  end,
}


