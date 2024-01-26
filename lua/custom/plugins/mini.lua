return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function ()
    local animate = require('mini.animate')
    animate.setup({
      scroll = {
        timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
      },
    })
  end
}
