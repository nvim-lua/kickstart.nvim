return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      json = { 'jq' },
      sarif = { 'jq' },
      python = { 'ruff_format', 'ruff_organize_imports' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      markdown = { 'markdownlint' },
      yaml = { 'prettier' },
    },
  },
}
