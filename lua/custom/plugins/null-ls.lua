return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      source = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
      }
    })
  end
}
