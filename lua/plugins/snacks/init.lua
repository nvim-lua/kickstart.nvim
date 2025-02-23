-- Import all configurations
local core = require("plugins.snacks.core")
local display = require("plugins.snacks.display")
local git = require("plugins.snacks.git")
local terminal = require("plugins.snacks.terminal")
local dashboard = require("plugins.snacks.dashboard")
local picker = require("plugins.snacks.picker")

-- Merge all configurations
local function merge_tables(...)
  local result = {}
  for _, t in ipairs({...}) do
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

-- Return the plugin spec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.nvim",
  },
  ---@type snacks.Config
  opts = merge_tables(
    core,
    display,
    git,
    terminal,
    dashboard,
    picker
  ),
  config = function(_, opts)
    -- Initialize snacks with merged options
    require("snacks").setup(opts)

    -- Note: Keymaps are handled in core/keymaps.lua
  end,
  init = function()
    -- Make snacks available globally for debugging
    _G.Snacks = require("plugins.snacks")
  end,
}
