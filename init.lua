-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'user.options'
require 'user.keymaps'
require 'user.plugins'
require 'user.colorscheme'
require 'user.cmp'
require 'user.lsp'
require 'user.telescope'
require 'user.treesitter'
require 'user.autopairs'
require 'user.nvim-tree'
require 'user.bufferline'
