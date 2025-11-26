return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  keys = {
    { '-', '<cmd>Oil<cr>', mode = 'n' },
  },
  config = function()
    require('oil').setup {
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
      },
      float = {
        border = 'none',
      },
      confirmation = {
        border = 'none',
      },
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true,
    }
  end,
}
