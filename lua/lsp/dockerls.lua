return {
  name = 'dockerls',
  cmd = { 'docker-langserver', '--stdio' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'Dockerfile', 'dockerfile', '.dockerignore' }, { upward = true })[1]),
  filetypes = { 'dockerfile', 'Dockerfile' },
}
