return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = "^1.0.0",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "gopls", "templ" },
        automatic_installation = true,
      })
    end,
  },
}
