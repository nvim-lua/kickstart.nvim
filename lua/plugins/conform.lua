return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- Disable formatters for .templ files
          templ = {},

          -- Add your other filetype configs here as needed
          -- e.g., go = { "gofmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
    event = { "BufReadPre", "BufNewFile" },
  }
}
