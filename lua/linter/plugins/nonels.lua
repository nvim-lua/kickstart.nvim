return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.jsonlint,
          -- null_ls.builtins.completion.spell,
        },
      }
    end,
  },
}
