return {
  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {},
    config = function()
      require('bufferline').setup {
        options = {
          numbers = 'none',
          close_command = 'Bdelete! %d',
          right_mouse_command = 'Bdelete! %d',
          indicator = {
            style = 'icon',
          },
          -- separator_style = 'slant',
        }
      }
    end,
  },
}
