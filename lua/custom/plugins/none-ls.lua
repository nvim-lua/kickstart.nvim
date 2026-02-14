-- Format on save and linters
return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
      'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
    },
    config = function()
      local null_ls = require 'null-ls'
      local formatting = null_ls.builtins.formatting -- to setup formatters
      local diagnostics = null_ls.builtins.diagnostics -- to setup linters

      -- list of formatters & linters for mason to install
      require('mason-null-ls').setup {
        ensure_installed = {
          'checkmake',
          'prettier', -- ts/js formatter
          'stylua', -- lua formatter
          'eslint_d', -- ts/js linter
          'shfmt',
          'ruff',
        },
        -- auto-install configured formatters & linters (with null-ls)
        automatic_installation = true,
      }

      local sources = {
        -- Linters
        diagnostics.checkmake,

        -- ESLint diagnostics (ESLint 9 compatible)
        require('none-ls.diagnostics.eslint_d').with {
          prefer_local = 'node_modules/.bin',
          filetypes = {
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
          },
          condition = function(utils)
            return utils.root_has_file {
              'eslint.config.js',
              'eslint.config.mjs',
              'eslint.config.cjs',
            }
          end,
        },

        -- ESLint code actions
        require('none-ls.code_actions.eslint_d').with {
          prefer_local = 'node_modules/.bin',
        },

        -- Formatters
        formatting.prettier.with {
          filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'json', 'yaml', 'markdown' },
        },

        formatting.stylua,
        formatting.shfmt.with { args = { '-i', '4' } },
        formatting.terraform_fmt,
        require('none-ls.formatting.ruff').with { extra_args = { '--config=pyproject.toml' } },
        -- require('none-ls.formatting.ruff_format').with { extra_args = { '--config=pyproject.toml' } },
      }

      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      null_ls.setup {
        -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
        sources = sources,
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
  },
}
