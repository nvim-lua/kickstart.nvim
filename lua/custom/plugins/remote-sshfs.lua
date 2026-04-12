-- Usage: :RemoteSSHFSConnect <user>@<ipaddress>:/path/to/file
return {
  'nosduco/remote-sshfs.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  opts = {},
}
