-- Lua quick doc reference https://learnxinyminutes.com/docs/lua/

-- Sets <space> as the <leader> key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootsrap plugin manager
require "core.bootstrap-plugin-manager"

require "core.plugins"
require "core.settings"
require "core.keymaps"
require "core.setup"

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
