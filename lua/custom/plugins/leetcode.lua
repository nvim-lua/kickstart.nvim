-- filepath: /home/kali/.config/nvim/lua/custom/plugins/leetcode.lua
-- LeetCode.nvim - Solve LeetCode problems within Neovim
-- https://github.com/kawre/leetcode.nvim

return {
  "kawre/leetcode.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional but recommended
    "nvim-treesitter/nvim-treesitter" -- make sure treesitter is a direct dependency
  },
  build = function()
    -- Make sure the HTML parser is installed for treesitter
    require("nvim-treesitter.install").ensure_installed("html")
  end,
  config = function()
    require("leetcode").setup({
      -- Default language for solving problems
      lang = "python3", -- you can change this to your preferred language
      
      -- Storage directories
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      
      -- Console settings
      console = {
        open_on_runcode = true,
        dir = "row", -- "row" or "col" for horizontal or vertical split
        size = {
          width = "90%",
          height = "75%",
        },
        result = {
          size = "60%",
        },
        testcase = {
          virt_text = true,
          size = "40%",
        },
      },
      
      -- Description panel settings
      description = {
        position = "left", -- "left" or "right"
        width = "40%", 
        show_stats = true, -- show problem stats in description panel
      },
      
      -- You can choose either telescope or fzf-lua
      picker = {
        provider = "telescope", -- set to "fzf-lua" if you prefer that
      },
      
      -- Default keybindings - these won't conflict with your existing mappings
      -- as they only activate within LeetCode buffers
      keys = {
        toggle = { "q" },
        confirm = { "<CR>" },
        
        reset_testcases = "r",
        use_testcase = "U",
        focus_testcases = "H",
        focus_result = "L",
      },
      
      -- Code injection settings - adds useful imports automatically
      injector = {
        ["cpp"] = {
          before = { "#include <bits/stdc++.h>", "using namespace std;" },
        },
        ["java"] = {
          before = "import java.util.*;",
        },
        ["python3"] = {
          before = true, -- use default imports
        },
      },
      
      -- Enable logging
      logging = true,
      
      -- Non-standalone mode (false means it won't interfere with your normal workflow)
      plugins = {
        non_standalone = false,
      },
    })
  end,
  cmd = "Leet", -- lazy-load on command
}
