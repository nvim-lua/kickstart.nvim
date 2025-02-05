vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('settings')
require('plugins')  -- Ensure this file uses lazy.nvim for loading plugins
require('keymaps')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  root = vim.fn.stdpath('data') .. '/lazy',
  defaults = {
    lazy = true,
  },
  spec = require('plugins').spec,  -- Load plugin specifications from plugins.lua
})
