-- File: lua/custom/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup {}
  end,
}
