return {
  'crnvl96/lazydocker.nvim',
  event = 'VeryLazy',
  opts = {}, -- automatically calls `require("lazydocker").setup()`
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>ld', '<cmd>LazyDocker<cr>', desc = 'LazyDocker' },
  },
}
