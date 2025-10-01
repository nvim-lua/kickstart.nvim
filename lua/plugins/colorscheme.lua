-- Kanagawa colorscheme configuration
return {
  "rebelot/kanagawa.nvim",
  config = function()
    require('kanagawa').setup({
      -- Available modes: 'wave', 'lotus', 'dragon'
      -- 'wave' - Default, balanced colors
      -- 'lotus' - Lighter, more pastel colors  
      -- 'dragon' - Darker, more vibrant colors
      theme = "wave", -- Change this to 'lotus' or 'dragon' for different modes
      
      -- Additional options
      transparent = false,
      terminal_colors = true,
      colors = {
        -- You can override specific colors here if needed
        -- palette = {},
        -- theme = {},
      },
      overrides = function(colors)
        return {
          -- Custom overrides can go here
        }
      end,
    })
    
    -- Set the colorscheme
    vim.cmd("colorscheme kanagawa")
  end,
}


