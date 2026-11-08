-- [[ Neovim Configuration ]]
-- Requires Neovim 0.12+ (uses the built-in plugin manager vim.pack).

-- Core configuration modules
require 'user.core.globals' -- Leader key and global variables
require 'user.core.options' -- Vim options and settings
require 'user.core.keymaps' -- Key mappings and shortcuts
require 'user.core.autocmds' -- Auto commands and events

-- Plugins: installed with vim.pack and configured in lua/user/plugins/
require 'user.plugins'

-- vim: ts=2 sts=2 sw=2 et
