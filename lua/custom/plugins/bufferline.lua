return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.minimal,
        indicator = {
          style = 'underline',
        },
        offsets = {
          {
            filetype = "NvimTree",
          }
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,
      }
    }
  end
}
