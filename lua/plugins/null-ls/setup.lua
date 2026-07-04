---@diagnostic disable: undefined-global
-- null-ls setup module
local M = {}

function M.setup()
  local null_ls = require 'null-ls'
  local null_ls_utils = require 'null-ls.utils'
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  local sources = {
    formatting.gofumpt.with({ extra_args = { "-extra" } }),
    formatting.goimports.with({ args = { "-local", "", "-w", "$FILENAME" } }),
    diagnostics.golangci_lint.with({
      diagnostics_format = '#{m}',
      extra_args = {
        '--fast',
        '--max-issues-per-linter', '30',
        '--max-same-issues', '4',
        '--max-same-issues-per-linter', '0',
        '--fix=false',
        '--tests=false',
        '--print-issued-lines=false',
        '--timeout=10s',
        '--out-format=json',
      },
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      timeout = 10000,
    }),
    formatting.prettier.with {
      filetypes = { 'css', 'scss', 'html', 'markdown', 'yaml', 'yml' },
      extra_args = {
        '--bracket-same-line',
        '--trailing-comma', 'all',
        '--tab-width', '2',
        '--semi',
        '--single-quote',
      },
    },
    formatting.shfmt.with { extra_args = { '-i', '2', '-ci', '-bn' } },
    formatting.sqlfluff.with { extra_args = { '--dialect', 'tsql' } },
  }

  null_ls.setup {
    root_dir = null_ls_utils.root_pattern('.null-ls-root', 'Makefile', '.git'),
    timeout = 10000,
    debounce = 250,
    update_in_insert = false,
    sources = sources,
  }
end

return M
