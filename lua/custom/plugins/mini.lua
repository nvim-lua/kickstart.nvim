return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    local bufremove = require("mini.bufremove")
    bufremove.setup()
    local cursorword = require("mini.cursorword")
    cursorword.setup()
  end
}
