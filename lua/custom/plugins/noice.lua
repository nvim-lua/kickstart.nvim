return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      messages = {
        enabled = false,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
}
