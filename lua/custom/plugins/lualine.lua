return {
    -- TODO: move to plugins
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = _G.THEME_NAME,
        component_separators = '|',
        section_separators = '||',
      },
      --winbar = {}  -- Not used, because `barbecue.nvim` uses it.
      tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
        {
            'filename',
            file_status = true,      -- Displays file status (readonly status, modified status)
            newfile_status = false,  -- Display new file status (new file means no write after created)
            path = 3,                -- 0: Just the filename
                                     -- 1: Relative path
                                     -- 2: Absolute path
                                     -- 3: Absolute path, with tilde as the home directory
                                     -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                                     -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[r]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }  
          },
        },
        lualine_x = {
          
        },
        lualine_y = {
                },
        lualine_z = {
          'windows',
          {
            'datetime',
            -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
            style = 'default'
          },
        },
      },
      sections = {
        lualine_a = {'mode', 'filename'},
        lualine_b = {
        'location',
          'searchcount',
          'diagnostics',
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {

          {
            'tabs',
            mode = 2, -- 0: Shows tab_nr
                -- 1: Shows tab_name
                -- 2: Shows tab_nr + tab_name
          }

        },
      },

    },
  }

