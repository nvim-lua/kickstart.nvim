-- lua/plugins/conform.lua
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Resolve templ binary
      local mason_templ = vim.fn.stdpath("data") .. "/mason/bin/templ"
      local templ_cmd = (vim.fn.executable(mason_templ) == 1) and mason_templ
          or ((vim.fn.executable("templ") == 1) and "templ" or nil)

      require("conform").setup({
        formatters = {
          templ_fmt = {
            command = templ_cmd or "templ",
            args = { "fmt", "-stdin-filepath", "$FILENAME", "-stdout" },
            stdin = true,
          },
          -- REMOVED manual goimports definition here. 
          -- Conform's built-in one works better.
        },
        formatters_by_ft = {
          templ      = { "templ_fmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          jsx        = { "prettier" },
          tsx        = { "prettier" },
          json       = { "prettier" },
          yaml       = { "prettier" },
          markdown   = { "prettier" },
          html       = { "prettier" },
          css        = { "prettier" },
          lua        = { "stylua" },
          -- Use goimports (which handles imports + fmt) 
          -- then gofmt (or gofumpt) as a secondary pass
          go         = { "goimports", "gofmt" }, 
        },
        format_on_save = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          if ft == "templ" then
            return { timeout_ms = 2000, lsp_fallback = false }
          end
          -- Increase timeout to 3000ms for Go to prevent the "timeout" issue
          if ft == "go" then
            return { timeout_ms = 3000, lsp_fallback = true }
          end
          return { timeout_ms = 1000, lsp_fallback = true }
        end,
      })
    end,
  },
}
