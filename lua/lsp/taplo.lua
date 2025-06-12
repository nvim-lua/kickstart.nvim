return {
  name = 'taplo',
  cmd = { 'taplo', 'lsp', 'stdio' },
  root_dir = vim.fs.dirname(vim.fs.find({ '.git', '*.toml' }, { upward = true })[1]),
  filetypes = { 'toml' },
}
