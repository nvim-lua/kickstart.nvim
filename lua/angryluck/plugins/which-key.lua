return { -- Shows pending keybinds
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    require("which-key").setup({
      -- Remove this if so many keymaps, that you need to scroll
      popup_mappings = {
        scroll_down = "<Nop>",
        scroll_up = "<Nop>",
      },
      -- Doesn't work
      -- trigger_blacklist = {
      --   v = { "j", "k", "<C-D>", "<C-U>" },
      -- },
    })

    -- Document existing key chains
    require("which-key").register({
      -- Naming leader-key-groups
      ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
      ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
      ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      ["<leader>o"] = { name = "[O]rgmode", _ = "which_key_ignore" },
    })
  end,
}
