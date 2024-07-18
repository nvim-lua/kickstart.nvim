return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          --section_separators = { left = '', right = '' },
          section_separators = { left = ' ', right = ' ' },
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
