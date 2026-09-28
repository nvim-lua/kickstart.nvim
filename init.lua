-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  vim.opt.rtp:prepend(lazypath)
end

vim.opt.rtp:prepend(lazypath)
vim.opt.clipboard= "unnamedplus"

-- Initialize lazy.nvim
require("lazy").setup({
  -- 1. Your File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({ view = { width = 30, side = "left" } })
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
    end,
  },

  -- 2. Catppuccin Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      -- Load catppuccin flavor: latte, frappe, macchiato, or mocha
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
})
