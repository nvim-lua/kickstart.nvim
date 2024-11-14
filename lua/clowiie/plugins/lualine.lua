return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local colors = {
      blue = '#80a0ff',
      cyan = '#79dac8',
      black = '#080808',
      white = '#c6c6c6',
      red = '#ff5189',
      violet = '#d183e8',
      grey = '#303030',
    }

    local theme = {
      normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white },
        c = { fg = colors.white },
        x = { fg = colors.white },
        y = { fg = colors.white },
        z = { fg = colors.white },
      },

      insert = { a = { fg = colors.black, bg = colors.blue } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },

      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
      },
    }

    require('lualine').setup {
      options = {
        theme = theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'diagnostics' },
        lualine_x = { 'location', 'encoding' },
        lualine_y = { 'filetype' },
        lualine_z = { 'fileformat' },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end,
}
