return {
  'petertriho/nvim-scrollbar',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'kevinhwang91/nvim-hlslens',
  },
  config = function()
    require 'gitsigns'
    require('scrollbar').setup()
    require('scrollbar.handlers.gitsigns').setup()
    require('scrollbar.handlers.search').setup {
      -- hlslens config overrides
    }
  end,
}
