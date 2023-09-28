local custom_onedark = require 'lualine.themes.onedark_dark'
custom_onedark.normal.c.bg = '#000000'

return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = custom_onedark,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
    },
}
