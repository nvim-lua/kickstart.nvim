-- Get LSP capabilities with cmp support
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
end

return {
  name = 'yamlls',
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yml' },
  root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'docker-compose.yml', 'docker-compose.yaml' }, { upward = true })[1]),
  capabilities = capabilities,
  settings = {
    telemetry = {
      enabled = false,
    },
    yaml = {
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '/docker-compose*.{yml,yaml}',
        ['https://json.schemastore.org/kustomization.json'] = 'kustomization.{yml,yaml}',
        ['https://json.schemastore.org/chart.json'] = '/Chart.{yml,yaml}',
      },
    },
  },
}
