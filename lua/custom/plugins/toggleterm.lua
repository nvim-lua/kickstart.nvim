return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {},
  config = function(_, opts)
    require('toggleterm').setup {
      open_mapping = [[<c-\>]],
      direction = 'float',
    }
  end,
}
