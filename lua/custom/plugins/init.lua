-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.colorcolumn = '80,100'
vim.opt.number = true
vim.opt.relativenumber = true

require('which-key').register({
  f = { ':Neoformat<CR>:EslintFixAll<CR>', 'Prettier then eslint' }
}, { prefix = '<leader>c' })

return {}
