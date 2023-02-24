return {
    'nvim-lualine/lualine.nvim',
    opts = {
options = {
    theme = 'onenord',
    icons_enabled = true,
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    -- lualine_c = {'filename'},
    lualine_c = {
      {
        'filename',
        file_status = true, -- Displays file status (readonly status, modified status)
        path = 1, -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path

        shorting_target = 40 -- Shortens path to leave 40 spaces in the window
        -- for other components. (terrible name, any suggestions?)
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
    },
  }
