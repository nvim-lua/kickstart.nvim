local opt = vim.opt

require("config.clipboard")

opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 0
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.inccommand = "split"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 10
opt.showmode = false
opt.signcolumn = "yes"
opt.shiftwidth = 2
opt.smartcase = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 250
