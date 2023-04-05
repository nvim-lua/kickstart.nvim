print("hello from options.lua")
-- [[ Setting options ]]
-- See `:help vim.o`
-- See also https://vimdoc.sourceforge.net/htmldoc/options.html#'incsearch'

-- options
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

-- window-local options
vim.wo.conceallevel = 0
vim.wo.cursorline = false
vim.wo.number = true
vim.wo.numberwidth = 4
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

-- buffer-local options
vim.bo.autoindent = true
vim.bo.expandtab = true
vim.bo.fileencoding = "utf-8"
vim.bo.shiftwidth = 4
vim.bo.smartindent = true
vim.bo.softtabstop = 2
vim.bo.swapfile = false
vim.bo.syntax = "ON"
vim.bo.tabstop = 8

-- global options
vim.g.background = 'dark'
vim.g.backup = true
vim.g.belloff = "all"
vim.g.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.g.compatible = false
vim.g.errorbells = false
vim.g.guifont = "monospace:h17"
vim.g.incsearch = true
vim.g.pumheight = 10
vim.g.scrolloff = 5
vim.g.showtabline = 2
vim.g.sidescrolloff = 5
vim.g.splitbelow = true
vim.g.splitright = true
vim.g.undodir = '~/.vim/undodir'
vim.g.writebackup = false
