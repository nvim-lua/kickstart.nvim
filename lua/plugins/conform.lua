-- lua/plugins/conform.lua
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Resolve templ binary (Mason first, else PATH)
      local mason_templ = vim.fn.stdpath("data") .. "/mason/bin/templ"
      local templ_cmd = (vim.fn.executable(mason_templ) == 1) and mason_templ
          or ((vim.fn.executable("templ") == 1) and "templ" or nil)

      if not templ_cmd then
        vim.notify("[conform.nvim] Could not find `templ` binary. Install via Mason or PATH.", vim.log.levels.WARN)
      end

      require("conform").setup({
        formatters = {
          templ_fmt = {
            command = templ_cmd or "templ",
            -- Read source from stdin, tell templ the filename for correct rules,
            -- and write formatted result to stdout (no in-place writes).
            args = { "fmt", "-stdin-filepath", "$FILENAME", "-stdout" },
            stdin = true,
          },
          goimports = {
            command = "goimports",
            args = {},
            stdin = true,
          },
        },
        formatters_by_ft = {
          templ      = { "templ_fmt" }, -- ✅ only templ fmt for .templ
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
          go         = { "goimports", "gofmt" },
        },
        format_on_save = function(bufnr)
          if vim.bo[bufnr].filetype == "templ" then
            return { timeout_ms = 2000, lsp_fallback = false } -- no LSP/Prettier fallback
          end
          return { timeout_ms = 1000, lsp_fallback = true }
        end,
      })
    end,
  },
}
