-- this needs to be here because doing it in init.lua is late for this plugin to work
vim.o.undofile = true
vim.o.undodir = '/tmp/.phoenix/undo'

return {
  'pixelastic/vim-undodir-tree',
}
