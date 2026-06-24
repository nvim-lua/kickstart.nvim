-- dbt language server (requires dbt-language-server in $PATH)
-- Uses native Neovim LSP APIs — no extra plugin needed.
vim.lsp.config('dbt', {
  cmd = { 'dbt-language-server' },
  filetypes = { 'sql', 'yaml' },
  root_markers = { 'dbt_project.yml' },
  settings = {},
})
vim.lsp.enable 'dbt'

return {}
