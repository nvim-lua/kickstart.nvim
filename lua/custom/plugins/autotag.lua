return { -- Auto close and change HTML tags
  'windwp/nvim-ts-autotag',
  config = function()
    require('nvim-ts-autotag').setup()
  end,
}
