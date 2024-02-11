-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.colorcolumn = '80,100'
vim.opt.number = true
vim.opt.relativenumber = true

local function lint_and_format()
  local filetype = vim.bo.filetype
  if
    filetype == 'javascript'
    or filetype == 'typescript'
    or filetype == 'javascriptreact'
    or filetype == 'typescriptreact'
  then
    vim.cmd('EslintFixAll')
  end
  vim.cmd('Neoformat')
end

require('which-key').register({
  f = { lint_and_format, 'Lint and format current buffer' }
}, { prefix = '<leader>c' })

return {}
