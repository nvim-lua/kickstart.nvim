vim.g.transparent_enabled = true
vim.g.transparency = 0.8
vim.wo.number = true
vim.o.relativenumber = true

vim.o.wrap = false
vim.o.smartindent = true
vim.o.ruler = true
vim.o.colorcolumn = "80"

vim.o.shiftround = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.guicursor = 'n-v-c-sm:block'
vim.opt.guifont = 'FiraCode Nerd Font'

vim.opt.shell = 'bash'
vim.o.shell = 'bash'
vim.opt.shellcmdflag = '-c'
vim.opt.termguicolors = true

require('custom.colors').LineNumberColors()
-- require('custom.colors').CursorLineColors()
require('custom.keymaps')
require('custom.neovide')
