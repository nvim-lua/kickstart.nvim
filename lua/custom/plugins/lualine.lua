-- ~/.config/nvim/lua/custom/plugins/plugins.lua

return {
  -- Custom Lualine configuration
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Ensure icons are available
    config = function()
      require 'custom.config.lualine_config' -- Path to your custom Lualine config
    end,
    event = 'VeryLazy', -- Lazy load Lualine
    priority = 1000, -- Ensure it loads before other plugins that might depend on it
  },
}
