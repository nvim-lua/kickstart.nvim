return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-\>]],
        persist_mode = true,
        direction = 'float',
        shell = 'zsh',
        close_on_exit = true,
      }
    end,
  },
}
