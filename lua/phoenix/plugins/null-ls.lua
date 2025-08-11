return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local b = null_ls.builtins

    local sources = {
      -- formatting
      -- b.formatting.prettierd,
      b.formatting.biome.with {
        condition = function(utils)
          return utils.root_has_file { 'biome.jsonc' }
        end,
        filetypes = { 'javascript', 'javascriptreact', 'json', 'jsonc', 'typescript', 'typescriptreact' },
        args = {
          'check',
          '--apply-unsafe',
          '--formatter-enabled=true',
          '--organize-imports-enabled=true',
          '--skip-errors',
          '--stdin-file-path=$FILENAME',
        },
      },
      b.formatting.stylua.with {
        condition = function(utils)
          return utils.root_has_file { 'stylua.toml', '.stylua.toml' }
        end,
      },

      -- b.formatting.goimports.with({
      --   args = {
      --     "-srcdir", "$DIRNAME", "-w", "cmd", "errorutils", "internal", "loaders", "resolvers"
      --   }
      -- }),

      -- b.formatting.beautysh,

      -- require("typescript.extensions.null-ls.code-actions"),

      -- b.formatting.eslint_d,

      -- b.diagnostics.eslint_d,
      -- b.code_actions.eslint_d,
    }

    null_ls.setup {
      -- debug = true,
      sources = sources,
    }
  end,
}

