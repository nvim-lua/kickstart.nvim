return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.sqlfmt,
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.diagnostics.glslc,
        null_ls.builtins.completion.spell,
      },
    })
    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end
}
