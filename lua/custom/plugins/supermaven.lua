return {
  {
    'supermaven-inc/supermaven-nvim',

    config = function()
      require('supermaven-nvim').setup {
        color = {
          suggestion_color = '#ffffff',
        },
      }
    end,
  },
}
