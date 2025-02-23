return {
  "jay-babu/mason-null-ls.nvim",
  enabled = true,
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim", -- replaces null-ls
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed =
      {
        "prettier",
        "eslint"
      },
      automatic_installation = true,
    })
  end,
}
