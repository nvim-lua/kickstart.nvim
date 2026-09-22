vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

pcall(require, "local.prehook")

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

pcall(require, "local.posthook")
