-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

local map = vim.api.nvim_set_keymap

map('n', '<leader>f', ':Telescope find_files<cr>', {noremap = false, silent = false})

return {}
