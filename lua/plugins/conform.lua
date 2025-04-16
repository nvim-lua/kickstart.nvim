return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          templ = { "templ", "prettier" }, -- Use templ first, then Prettier for embedded content
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
    event = { "BufReadPre", "BufNewFile" }, -- Load only when opening a file
  }
}
