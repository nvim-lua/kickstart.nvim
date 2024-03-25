return {
    {
      "nvimtools/none-ls.nvim",
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.diagnostics.erb_lint,
            null_ls.builtins.diagnostics.rubocop,
            null_ls.builtins.formatting.rubocop,
          },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      end,
    }
}