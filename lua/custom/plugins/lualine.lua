return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'dracula',
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_a = {
            'mode',
            'buffers',
          },
          lualine_c = {},
        },
      }
    end,
  },
}
