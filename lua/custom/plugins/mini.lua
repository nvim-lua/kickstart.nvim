return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    local animate = require('mini.animate')
    animate.setup({
      cursor = {
        timing = animate.gen_timing.exponential({ duration = 250, unit = 'total' }),
        path = animate.gen_path.angle(),
      },
      scroll = {
        timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
      },
    })
  end
}
