return {
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-go").setup()
  end,
}
