return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = require('plugins.bufferline.setup').opts,
  config = function(_, opts)
    require('plugins.bufferline.setup').setup()
  end,
}
