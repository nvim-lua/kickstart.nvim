vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

-- line numbers 
opt.relativenumber = true
opt.number = true

-- tabs & indentation 
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrap 
opt.wrap = false

-- Sync clipboard between OS and Neovim.
opt.clipboard = 'unnamedplus'
