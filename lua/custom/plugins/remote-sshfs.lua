return {
  'nosduco/remote-sshfs.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  opts = {},
}

-- Usage: :RemoteSSHFSConnect <user>@<ipaddress>:/path/to/file
-- Sometimes you have to force close, and that causes permission failed on reconnect.
-- When that happens DO NOT DELETE THE DIRECTORY under .sshfd. That will delete everything that mountpoint is connected to *at the connection*
-- Instead safely unmount with `umount -l ~/.sshfd/[MOUNT_POINT]`
