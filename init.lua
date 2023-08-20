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

require("defaults.keymaps")
require("defaults.settings")
require("defaults.autocmds")

-- Added this line to our initial lazy-config.lua file (Remove this comment if you want to)
require("lazy").setup('plugins')
