-- **conform.nvim**
-- This nvim plugin allows to format any buffer with a single command.
-- Plugin page: https://github.com/stevearc/conform.nvim
return {
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        javascript = { { "prettier" } },
        typescript = { { "prettier" } },
        html = { { "prettier" } },
        css = { { "prettier" } },
        sql = { { "sql_formatter" } },
      },
    },
  },
}
