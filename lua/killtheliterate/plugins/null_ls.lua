return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.codespell,
        -- require("none-ls.diagnostics.eslint_d").with({
        --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        -- }),
        null_ls.builtins.diagnostics.stylelint.with({
          filetypes = { "scss", "css" },
        }),
        null_ls.builtins.formatting.prettierd,
      },
    })
  end
}
