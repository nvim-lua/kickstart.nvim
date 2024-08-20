-- Install package manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

vim.cmd('filetype plugin on')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('config.lazy')
require('config.autocmds')
require('config.options')
require('config.mappings')
require('config.utils')
require('config.themes')

