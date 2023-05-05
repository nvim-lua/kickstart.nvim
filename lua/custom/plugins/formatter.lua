return {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.black.with({
             extra_args = {"--line-length=120", "--skip-string-normalization"},
          }),
        },
      }
    end,
}
