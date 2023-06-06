return {
  "goolord/alpha-nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    require('alpha').setup(dashboard.opts)
  end,
}
