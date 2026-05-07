return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = nil,
  config = function()
    require('plugins.nvim-autopairs.setup').setup(require('plugins.nvim-autopairs.setup').opts)
  end,
}
