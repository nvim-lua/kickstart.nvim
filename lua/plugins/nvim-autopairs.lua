return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",  -- Only load in insert mode
  opts = nil,
  config = function()
    require('plugins.nvim-autopairs.setup').setup(require('plugins.nvim-autopairs.setup').opts)
  end,
}
