-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Load configuration modules
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.lazy')