
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
      ensure_installed = { "gopls", "ts_ls", "templ", "astro" },
      automatic_installation = true,
      automatic_setup = false, -- IMPORTANT: don't auto-setup servers
    },
  },
}
