return {
  'norcalli/nvim-base16.lua',
  lazy = false,
  priority = 1000,
  config = function()
    local base16 = require 'base16'

    base16(base16.themes[vim.env.BASE16_THEME or "3024"], true)
  end,
}
