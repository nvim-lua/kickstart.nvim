return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    config = function()
      require('tiny-inline-diagnostic').setup()
    end,
  },
}
