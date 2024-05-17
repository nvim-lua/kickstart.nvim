return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'folke/noice.nvim' },
    },
    config = function(_, opts)
      local noice = require 'noice'
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' } } },
          lualine_x = {
            {
              noice.api.status.message.get_hl,
              cond = noice.api.status.message.has,
            },
            {
              noice.api.status.command.get,
              cond = noice.api.status.command.has,
              color = { fg = '#ff9e64' },
            },
            {
              noice.api.status.mode.get,
              cond = noice.api.status.mode.has,
              color = { fg = '#ff9e64' },
            },
            {
              noice.api.status.search.get,
              cond = noice.api.status.search.has,
              color = { fg = '#ff9e64' },
            },
          },
          lualine_z = {
            {
              'location',
              separator = { right = '' },
              left_padding = 2,
            },
          },
        },
        extensions = {
          'oil',
          'lazy',
        },
      }
    end,
  },
}
