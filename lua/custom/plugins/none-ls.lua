local M = {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}

function M.config()
  local null_ls = require('null-ls')

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  local completions = null_ls.builtins.completion

  null_ls.setup({
    debug = false,
    sources = {
      formatting.stylua,
      formatting.black,
      formatting.prettier.with({
        filetypes = {
          'css',
          'scss',
          'less',
          'html',
          'json',
          'jsonc',
          'yaml',
          'toml',
          'markdown',
          'markdown.mdx',
          'graphql',
          'handlebars',
        },
        -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      }),
      formatting.eslint_d,
      diagnostics.eslint_d,
      diagnostics.flake8,
      -- diagnostics.flake8,
      code_actions.eslint_d,
    },
  })
end

return M
