-- toggleterm.lua
-- A plugin that helps manage multiple terminal windows in Neovim
-- Github: https://github.com/akinsho/toggleterm.nvim

return {
  -- The repository on GitHub
  'akinsho/toggleterm.nvim',
  
  -- Use the latest stable version
  version = "*",
  
  -- Configuration options for the plugin
  opts = {
    -- Ctrl+\ will toggle the terminal visibility
    open_mapping = [[<c-\>]],
    
    -- Terminal appears as a floating window by default
    direction = 'float',
    
    -- How the floating window should look
    float_opts = {
      -- Curved borders for a nicer appearance
      border = 'curved',
    },
    
    -- Slightly dim the terminal background
    shade_terminals = true,
    
    -- How much to dim the terminal (0-100)
    shading_factor = 2,
    
    -- Function to determine size based on terminal direction
    size = function(term)
      if term.direction == "horizontal" then
        -- 15 lines height for horizontal terminals
        return 15
      elseif term.direction == "vertical" then
        -- 40% of window width for vertical terminals
        return vim.o.columns * 0.4
      end
    end,
  },
  
  -- Extra key mappings for different terminal layouts
  keys = {
    -- Leader+th opens a horizontal terminal at the bottom
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
    
    -- Leader+tv opens a vertical terminal at the side
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
    
    -- Leader+tf opens a floating terminal (alternative to Ctrl+\)
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
    
    -- Leader+tt opens a new terminal tab
    { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "Terminal Tab" },
  },
}