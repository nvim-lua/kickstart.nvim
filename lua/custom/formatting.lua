local M = {}

M.indent_by_ft = {
  javascript = 2,
  javascriptreact = 2,
  typescript = 2,
  typescriptreact = 2,
  json = 2,
  html = 2,
  css = 2,
  scss = 2,
}

M.formatters_by_ft = {
  html = { 'prettier' },
  lua = { 'stylua' },
  python = {
    'ruff_fix',
    'ruff_format',
    'ruff_organize_imports',
  },
  javascript = { 'prettierd', 'prettier', stop_after_first = true },
  typescript = { 'prettierd', 'prettier', stop_after_first = true },
}

return M
