return {
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.pylint,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.spectral,
          -- null_ls.builtins.completion.spell,
        },
      }
    end,
  },
}
