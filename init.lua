print 'waddup'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- NOTE: Further customisation found in /lua/

-- [[ Setting options ]]

require 'options'

-- [[ Basic Keymaps ]]

require 'keymaps'

-- [[ Plugin Manager ]]

require 'plugins'

--[[

  Forked from https://github.com/nvim-lua/kickstart.nvim
  Shoutouts to tj and the other contributors for making kickstart

  Stuck?
    - :help
    - :Tutor

  Errors?
    - :checkhealth

  Lua info:
    - https://learnxinyminutes.com/docs/lua/
    - :help lua-guide

  Keymaps:
    - Found in this file for now
    - [ ]sh to search

]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
