-- Sniprun plugin configuration
-- https://github.com/michaelb/sniprun

return {
  "michaelb/sniprun",
  branch = "master",
  build = "sh install.sh",
  -- Lazy load on keys
  config = function()
    require("sniprun").setup({
      -- Display the output more efficiently
      display = {
        "Classic",       -- Display stdout in the command line
        "VirtualTextOk", -- Display successful results as virtual text
        "FloatingWindow" -- Display results in a floating window
      },
      -- Optimize display options
      display_options = {
        terminal_width = 45,
        notification_duration = 5 -- in seconds
      },
      -- Configure specific languages (focus on the most commonly used)
      repl_enable = { 
        "Python3_original", 
        "JS_TS_deno", 
        "Lua_nvim" 
      },
      -- Python interpreter configuration with optimized path
      interpreter_options = {
        Python3_original = {
          command = "/home/kali/.local/share/pipx/venvs/klepto/bin/python",
        }
      },
    })
  end,
  -- Define keymaps directly in the keys table
  keys = {
    { "<leader>Sr", "<Plug>SnipRun", mode = "n", desc = "Run code snippet" },
    { "<leader>Sr", "<Plug>SnipRun", mode = "v", desc = "Run selected code" },
    { "<leader>Sc", "<Plug>SnipClose", desc = "Close sniprun output" },
    { "<leader>SR", "<Plug>SnipReset", desc = "Reset sniprun" },
    { "<leader>Si", "<Plug>SnipInfo", desc = "Sniprun info" },
    { "<F5>", "<Plug>SnipRunOperator", desc = "Sniprun operator mode" },
  }
}
