-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

local opt = vim.opt;

opt.mouse = ""
opt.nu = true
opt.guicursor = ""
opt.cursorline = false
opt.clipboard = ""
opt.scrolloff = 8
opt.conceallevel = 0
