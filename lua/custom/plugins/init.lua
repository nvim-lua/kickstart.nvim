-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.colorcolumn = "80,100"
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_set_keymap('n', '<leader>cf', ':EslintFixAll<CR>:Neoformat<CR>', { noremap = true, silent = true })

return {}
