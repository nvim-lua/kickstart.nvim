return {
  "folke/neodev.nvim",
  config = function()
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })
  end,
  opts = {},
}
