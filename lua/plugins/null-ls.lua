return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    require('plugins.null-ls.setup').setup()
  end,
}
