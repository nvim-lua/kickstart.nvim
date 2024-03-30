return {
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>up",
      function()
        local Util = require("lazy.core.util")
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          Util.warn("Disabled auto pairs", { title = "Option" })
        else
          Util.info("Enabled auto pairs", { title = "Option" })
        end
      end,
      desc = "Toggle auto pairs",
    }
  }
}
