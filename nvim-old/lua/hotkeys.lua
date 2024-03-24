vim.g.mapleader = " "
--mapleader = vim.g.mapleader
local builtin = require('telescope.builtin')

vim.keymap.set("n", "<Leader>E", vim.cmd.Ex)
-- vim.keymap.set('n', "<Leader>to", function() require('telescope.builtin').oldfiles() end)
vim.keymap.set('n', "<Leader>to", builtin.oldfiles, {})
