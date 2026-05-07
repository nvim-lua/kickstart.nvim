---@diagnostic disable: undefined-global
-- Quick navigation plugin
return {
  url = "https://codeberg.org/andyg/leap.nvim",
  dependencies = {
    'tpope/vim-repeat',  -- For dot-repeat support
  },
  config = function()
    local leap = require('leap')
    
    -- Basic setup
    leap.setup {
      case_sensitive = false,
      safe_labels = {},  -- Show all labels
      labels = {
        'f', 'j', 'd', 'k', 's', 'l', 'h', 'g',
        'F', 'J', 'D', 'K', 'S', 'L', 'H', 'G',
      },
    }

    -- Set highlight colors for better visibility
    vim.api.nvim_set_hl(0, 'LeapMatch', { fg = '#89B4FA', bold = true, nocombine = true })
    vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#cfa369', bold = true, nocombine = true })
    vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = '#94E2D5', bold = true, nocombine = true })
  end,
}
