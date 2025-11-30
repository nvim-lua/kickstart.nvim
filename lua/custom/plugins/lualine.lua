return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox', -- Matches global Gruvbox theme
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'NvimTree' },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        -- Section A: Mode (like airline)
        lualine_a = { 'mode' },

        -- Section B: Git branch and diff (like airline's VCS info)
        lualine_b = {
          'branch',
          'diff',
        },

        -- Section C: Filename with readonly/modified status (like airline)
        lualine_c = {
          {
            'filename',
            file_status = true, -- displays file status (readonly, modified)
            path = 1, -- 0: filename, 1: relative path, 2: absolute path
            shorting_target = 40,
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
            },
          },
          'diagnostics', -- LSP diagnostics
        },

        -- Section X: Filetype (like airline)
        lualine_x = {
          {
            'filetype',
            colored = true,
            icon_only = false,
          },
        },

        -- Section Y: File encoding and format (like airline: utf-8[unix])
        lualine_y = {
          {
            'encoding',
            fmt = string.upper,
          },
          {
            'fileformat',
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
        },

        -- Section Z: Position (like airline: 10% ☰ 10/100 ln : 20)
        lualine_z = {
          'progress',
          'location',
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'nvim-tree', 'lazy', 'mason', 'toggleterm' },
    }
  end,
}
