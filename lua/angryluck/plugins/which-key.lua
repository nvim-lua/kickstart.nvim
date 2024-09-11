return { -- Shows pending keybinds
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    popup_mappings = {
      scroll_down = "<Nop>",
      scroll_up = "<Nop>",
    },
  },

  config = function()
    require("which-key").setup({
      -- Remove this if so many keymaps, that you need to scroll
      -- popup_mappings = {
      --   scroll_down = "<Nop>",
      --   scroll_up = "<Nop>",
      -- },
      -- Doesn't work
      -- trigger_blacklist = {
      --   v = { "j", "k", "<C-D>", "<C-U>" },
      -- },
    })

    -- Document existing key chains
    require("which-key").add({
      -- Naming leader-key-groups
      { "<leader>c", group = "[C]ode" },
      { "<leader>c_", hidden = true },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>d_", hidden = true },
      { "<leader>o", group = "[O]rgmode" },
      { "<leader>o_", hidden = true },
      { "<leader>r", group = "[R]ename" },
      { "<leader>r_", hidden = true },
      { "<leader>s", group = "[S]earch" },
      { "<leader>s_", hidden = true },
      { "<leader>w", group = "[W]orkspace" },
      -- old: require("which-key").register:
      -- ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
      -- ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
      -- ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
      -- ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      -- ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      -- ["<leader>o"] = { name = "[O]rgmode", _ = "which_key_ignore" },
    })
  end,
}
