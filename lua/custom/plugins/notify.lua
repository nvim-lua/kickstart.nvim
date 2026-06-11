return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup {
      background_colour = '#000000',
      stages = 'fade',
      timeout = 300,
      render = 'wrapped-compact',
    }

    -- MUST be after setup
    vim.notify = require 'notify'
  end,
}
