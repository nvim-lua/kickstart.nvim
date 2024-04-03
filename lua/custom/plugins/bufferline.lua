local M = {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
}

function M.config()
  local bufferLine = require 'bufferline'
  bufferLine.setup {
    options = {
      mode = 'buffers',
      style_preset = bufferLine.style_preset.default,
      themable = true,
      numbers = 'ordinal',
      close_command = 'bdelete! %d', -- can be a string | function, | false see "Mouse actions"
      right_mouse_command = 'bdelete! %d', -- can be a string | function | false, see "Mouse actions"
      left_mouse_command = 'buffer %d', -- can be a string | function, | false see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
      indicator = {
        icon = '▎', -- this should be omitted if indicator style is not 'icon'
        style = 'icon',
      },
      buffer_close_icon = '󰅖',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      show_close_icon = true,
      show_tab_indicators = true,
    },
  }
end

return M
