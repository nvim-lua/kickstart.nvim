-- lua/plugins/mason.lua
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "gopls", "templ",  "vtsls" }, -- 👈 add this
      automatic_installation = true,
      automatic_setup = false,
    },
  },
}
