return {
  -- custom config which piggybacks on the copilot extras in lazy.lua.
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          accept = false, -- disable built-in keymapping
          keymap = {
            accept = "<C-Enter>",
            next = "<C-n>",
            prev = "<C-p>",
            -- dismiss = "<ESC>",
          },
        },
      })
    end,
  },
}
