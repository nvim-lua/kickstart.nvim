return {
  name = 'nixd',
  cmd = { 'nixd' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'flake.nix', 'default.nix', 'shell.nix' }, { upward = true })[1]),
  filetypes = { 'nix' },
}
