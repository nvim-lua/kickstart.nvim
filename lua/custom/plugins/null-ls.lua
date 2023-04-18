return {
  "jose-elias-alvarez/null-ls.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
      },
    }
  end,
}
