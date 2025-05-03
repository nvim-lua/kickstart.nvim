-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h10" }

if vim.g.neovide then
    vim.cmd("cd ~")
end
