return {
  "asiryk/auto-hlsearch.nvim",
  dependencies = { "asiryk/auto-hlsearch.nvim", tag = "1.1.0" },
  config = function()
    require("auto-hlsearch").setup()
  end,
}
