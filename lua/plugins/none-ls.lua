return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
      },
    }
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = '[C]ode [F]ormatting' })
  end,
}
