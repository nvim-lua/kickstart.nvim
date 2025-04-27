---@diagnostic disable: undefined-global
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'gruvbox',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          'filename',
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
            colored = true,
            update_in_insert = false,
            always_visible = true,
          },
          {
            function()
              -- Get the navic location with a more reliable approach
              local location = require('nvim-navic').get_location()
              if location and location ~= "" then
                return "📍 " .. location  -- Add an icon for better visibility
              end
              return ""
            end,
            cond = function()
              return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
            end,
            color = { fg = '#a3be8c', gui = 'bold' },  -- Make it more visible with color
          },
        },
        lualine_x = {
          {
            function()
              local qf_list = vim.fn.getqflist()
              local count = #qf_list
              if count > 0 then
                return 'QF:' .. count
              else
                return ''
              end
            end,
            icon = '',
            color = { fg = '#d7af5f', gui = 'bold' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'quickfix' },
    }
  end,
}
