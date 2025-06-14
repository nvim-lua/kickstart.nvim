-- --[[
--   Which-Key Integration Plugin - Latest v3 Configuration

--   This file sets up which-key with the latest v3 API and configuration.
--   which-key v3 uses a new spec-based system for defining keymaps.
-- ]]

-- return {
--   {
--     'folke/which-key.nvim',
--     event = "VeryLazy",
--     opts = {
--       preset = "modern", -- "classic", "modern", or "helix"
--       delay = function(ctx)
--         return ctx.plugin and 0 or 200
--       end,
--       plugins = {
--         marks = true,       -- shows a list of your marks on ' and `
--         registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
--         spelling = {
--           enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
--           suggestions = 20, -- how many suggestions should be shown in the list?
--         },
--         presets = {
--           operators = true,    -- adds help for operators like d, y, ...
--           motions = true,      -- adds help for motions
--           text_objects = true, -- help for text objects triggered after entering an operator
--           windows = true,      -- default bindings on <c-w>
--           nav = true,          -- misc bindings to work with windows
--           z = true,            -- bindings for folds, spelling and others prefixed with z
--           g = true,            -- bindings for prefixed with g
--         },
--       },
--       spec = {
--         { "g", group = "goto" },
--         { "gz", group = "surround" },
--         { "]", group = "next" },
--         { "[", group = "prev" },
--         { "<leader><tab>", group = "tabs" },
--         { "<leader>b", group = "buffer" },
--         { "<leader>c", group = "code" },
--         { "<leader>f", group = "file/find" },
--         { "<leader>g", group = "git" },
--         { "<leader>h", group = "harpoon" },
--         { "<leader>l", group = "leetcode" },
--         { "<leader>n", group = "neorg" },
--         { "<leader>q", group = "quit/session" },
--         { "<leader>s", group = "search" },
--         { "<leader>t", group = "toggle/tab" },
--         { "<leader>w", group = "windows" },
--         { "<leader>x", group = "diagnostics/quickfix" },
--       },
--       icons = {
--         breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
--         separator = "→", -- symbol used between a key and it's label
--         group = "+", -- symbol prepended to a group
--         mappings = vim.g.have_nerd_font,
--       },
--       win = {
--         border = "rounded",       -- none, single, double, shadow, rounded
--         position = "bottom",      -- bottom, top
--         margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
--         padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
--         winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
--       },
--       layout = {
--         height = { min = 4, max = 25 }, -- min and max height of the columns
--         width = { min = 20, max = 50 }, -- min and max width of the columns
--         spacing = 3,                    -- spacing between columns
--         align = "center",               -- align columns left, center or right
--       },
--       show_help = true,         -- show help message on the command line when the popup is visible
--       show_keys = true,         -- show the currently pressed key and its label as a message in the command line
--     },
--     config = function(_, opts)
--       local wk = require("which-key")
--       wk.setup(opts)
      
--       -- Use vim.schedule to ensure modules are loaded after Vim is ready
--       vim.schedule(function()
--         -- Load which-key setup with customized configuration
--         require('custom.which_key_setup').setup()
        
--         -- Load core keymaps
--         pcall(function() require('custom.keymaps').setup() end)
        
--         -- Load plugin-specific keymaps
--         pcall(function() require('custom.plugin_keymaps').setup() end)
--       end)
--     end,
--     -- Load on specific events with higher priority
--     event = "VeryLazy",
--     priority = 1000, -- High priority to ensure it loads first
--   }
-- }
--[[
  Which-Key Integration Plugin - Latest v3 Configuration

  This file sets up which-key with the latest v3 API and configuration.
  Official documentation: https://github.com/folke/which-key.nvim
]]

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern", -- "classic", "modern", or "helix"
      -- Delay before showing the popup. Can be a number or a function that returns a number.
      -- 0 to disable, or a function that returns the delay based on the current context
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      
      -- Filter to exclude mappings without descriptions or that match certain patterns
      filter = function(mapping)
        -- Exclude mappings without descriptions
        return mapping.desc and mapping.desc ~= ""
      end,
      
      -- You can add any mappings here, or use `require("which-key").add()` later
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>b", group = "buffer" },
          { "<leader>c", group = "code/copilot" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>h", group = "harpoon" },
          { "<leader>l", group = "leetcode" },
          { "<leader>n", group = "neorg" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>t", group = "toggle/tab" },
          { "<leader>u", group = "ui" },
          { "<leader>w", group = "windows" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
        },
      },
      
      -- Window configuration
      win = {
        border = "rounded",
        no_overlap = true,
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
      
      -- Layout configuration
      layout = {
        width = { min = 20 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
      },
      
      -- Key bindings for the which-key buffer
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      
      -- Sort mappings
      sort = { "local", "order", "group", "alphanum", "mod" },
      
      -- Expand groups when <= n mappings
      expand = 0,
      
      -- Replacements for how keys and descriptions are displayed
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          -- { "<Space>", "SPC" },
        },
        desc = {
          { "<Plug>%(?(.*)%)?", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      
      -- Icons configuration
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
        ellipsis = "…",
        mappings = vim.g.have_nerd_font, -- set to false to disable all mapping icons
        rules = {},
        colors = true,
        -- Icon keys for different key types
        keys = vim.g.have_nerd_font and {} or {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
      
      -- Show help and keys
      show_help = true,
      show_keys = true,
      
      -- Disable which-key for certain file types or buffer types
      disable = {
        buftypes = {},
        filetypes = {},
      },
    },
    
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      
      -- Load keymap modules after which-key is ready
      vim.schedule(function()
        -- Load core keymaps if they exist
        local core_keymaps_ok, _ = pcall(require, 'custom.keymaps')
        if core_keymaps_ok then
          pcall(function() require('custom.keymaps').setup() end)
        end
        
        -- Load which-key specific setup
        local wk_setup_ok, _ = pcall(require, 'custom.which_key_setup')
        if wk_setup_ok then
          pcall(function() require('custom.which_key_setup').setup() end)
        end
        
        -- Load plugin-specific keymaps
        local plugin_keymaps_ok, _ = pcall(require, 'custom.plugin_keymaps')
        if plugin_keymaps_ok then
          pcall(function() require('custom.plugin_keymaps').setup() end)
        end
      end)
    end,
  }
}
