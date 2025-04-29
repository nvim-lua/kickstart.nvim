return {
  'ggandor/leap.nvim',
  init = function()
    require('leap').add_default_mappings()
  end,
  dependencies = {
    'tpope/vim-repeat',
  },
  lazy = false,
}
