-- Leader/options must be set before plugins load
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.commands'
require 'config.lazy'

vim.cmd.colorscheme 'vague'
-- vim.cmd.colorscheme 'github_dark_default'
-- vim.cmd.colorscheme 'monokai-pro-machine'
-- vim: ts=2 sts=2 sw=2 et
