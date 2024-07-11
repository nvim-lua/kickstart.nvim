local function get_oil_extension()
  local oil_ext = vim.deepcopy(require 'lualine.extensions.oil')
  oil_ext.sections.lualine_b = { { 'pwd' } }
  oil_ext.sections.lualine_z = {
    {
      'mode',
      separator = { left = '', right = '' },
      fmt = function(mode, context)
        local winnr = vim.fn.tabpagewinnr(context.tabnr)
        local val = require('fancyutil').get_oil_nnn(winnr)
        if val then
          return 'nnn'
        end
        return mode
      end,
      color = function()
        local val = require('fancyutil').get_oil_nnn()
        if val then
          return { fg = '#054fca', bg = '#ff98dd' }
        end
      end,
    },
  }
  return oil_ext
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'folke/noice.nvim' },
      { 'arkav/lualine-lsp-progress' },
    },
    config = function()
      local colors = {
        gray = '#6c7086',
        purple = '#cba6f7',
      }

      require('lualine').setup {
        options = {
          theme = 'catppuccin',
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            -- '%=',
            {
              'filename',
              file_status = true,
              path = 3,
              symbols = {
                modified = '', -- Text to show when the file is modified.
                readonly = '󰌾', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                newfile = '[New]', -- Text to show for newly created file before first write
              },
            },
          },
          lualine_x = {
            { 'filetype' },
            { 'fileformat' },
          },
          lualine_y = {},
          lualine_z = {},
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = '', right = '' },
            },
          },
          lualine_x = {
            {
              'lsp_progress',
              display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
              colors = {
                percentage = colors.gray,
                title = colors.gray,
                message = colors.gray,
                spinner = colors.gray,
                lsp_client_name = colors.purple,
                use = true,
              },
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              timer = {
                progress_enddelay = 1500,
                spinner = 1500,
                lsp_client_enddelay = 2500,
              },
            },
          },
          lualine_z = {
            {
              'location',
              separator = { left = '', right = '' },
            },
          },
        },
        extensions = {
          get_oil_extension(),
          'lazy',
        },
      }
    end,
  },
}
