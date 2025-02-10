vim.lsp.start {
  cmd = { 'openapi-language-server', '-testdata', '/tmp/xyz.txt' },
  filetypes = { 'yaml.openapi', 'yaml.oa', 'yaml' },
  root_dir = vim.fn.getcwd(),
}
