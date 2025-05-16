vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

require 'user.options'
require 'user.keymaps'
require 'user.colorscheme'
-- require 'user.cmp'
-- require 'user.lsp'
-- require 'user.treesitter'
-- require 'user.autopairs'
-- require 'user.nvim-tree'
-- require 'user.bufferline'
