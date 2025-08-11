local keymap = require 'phoenix.utils.keymap'

return {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lspsaga').setup {
      symbol_in_winbar = {
        enable = false,
        separator = ' › ',
        hide_keyword = false,
        show_file = true,
        folder_level = 2,
        color_mode = true,
        delay = 300,
      },
      lightbulb = {
        enable = false,
        sign = true,
        debounce = 10,
        sign_priority = 40,
        virtual_text = false,
        enable_in_insert = true,
      },
      ui = {
        code_action = "·",
        devicon = false
      }
    }


    keymap('n', '<leader>lo', ':Lspsaga outline<cr>')
    keymap('n', '<leader>lf', ':Lspsaga finder<cr>')
  end,
}
