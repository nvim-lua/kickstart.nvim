return {
  'thomasmarcel/tune.nvim',
  config = function()
    local tune = require 'tune'
    tune.setup()
    tune.pick_random_colorscheme()
  end,
  priority = 10,
}
