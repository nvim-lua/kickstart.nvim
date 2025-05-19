vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.encoding = 'UTF-8'
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
vim.opt.spelloptions:append 'camel'
vim.opt.spellcapcheck = '' -- disable checking for capital letters at the start of sentences
vim.lsp.set_log_level 'debug'
