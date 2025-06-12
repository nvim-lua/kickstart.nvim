return {
  name = 'marksman',
  cmd = { 'marksman', 'server' },
  root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.marksman.toml' }, { upward = true })[1]),
  filetypes = { 'markdown', 'md' },
}
