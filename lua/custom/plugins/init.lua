-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  vim.keymap.set('n', '<space>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>'),
  vim.keymap.set('n', '<space>ng', ':Neogit cwd=%:p:h<CR>'),

  require('mini.surround').setup(),

  require('mini.pairs').setup(),

  require('mini.indentscope').setup {
    options = { try_as_border = true },
    symbol = '│',
    draw = {
      delay = 200,
      animation = function()
        return 1
      end,
    },
  },
}
