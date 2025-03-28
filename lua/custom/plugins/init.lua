-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'levouh/tint.nvim',
    config = function()
      -- Override some defaults
      require('tint').setup {
        tint = -45, -- Darken colors, use a positive value to brighten
        saturation = 0.6, -- Saturation to preserve
        transforms = require('tint').transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
        tint_background_colors = true, -- Tint background portions of highlight groups
        highlight_ignore_patterns = { 'WinSeparator', 'Status.*' }, -- Highlight group patterns to ignore, see `string.find`
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, 'buftype')
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ''

          -- Do not tint `terminal` or floating windows, tint everything else
          return buftype == floating --"terminal" or
        end,
      }
    end,
  },
  {
    'mvllow/modes.nvim',
    config = function()
      require('modes').setup {
        colors = {
          copy = '#DC9A0C',
          delete = '#C73000',
          insert = '#006600',
          visual = '#9745be',
          default = '#FFFFFF',
          normal = 'white',
        },

        -- Set opacity for cursorline and number background
        line_opacity = 0.5,

        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,

        -- Enable line number highlights to match cursorline
        set_number = true,

        -- Disable modes highlights in specified filetypes
        -- Please PR commonly ignored filetypes
        ignore_filetypes = { 'NvimTree', 'TelescopePrompt' },
      }
    end,
    vim.opt.guicursor:append 'n-c:block-Cursor',
  },
  -- {
  --   'github/copilot.vim',
  -- },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup {}
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          --lualine_x = { 'filetype', 'encoding' }, -- "fileformat",
          --lualine_y = { "progress" },
          lualine_z = { 'location' },
          lualine_x = {
            'copilot',
            'encoding',
            'fileformat',
            'filetype',
          },

          --inactive_sections = {
          --	lualine_a = {},
          --	lualine_b = {},
          --	lualine_c = { "filename" },
          --	lualine_x = { "location" },
          --	lualine_y = {},
          --a	lualine_z = {},
          --},
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {},
        },
      }
    end,
  },
  { 'ofseed/copilot-status.nvim' },
  --{ 'AndreM222/copilot-lualine' },
  { -- know what is possible at the command line
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require 'wilder'
      wilder.setup { modes = { ':', '/', '?' } }
    end,
  },

  { -- shows the colors in files e.g. #CCAA33
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
} -- end of return
