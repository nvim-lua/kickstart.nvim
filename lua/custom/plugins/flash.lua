return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = false,
        jump_labels = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "/", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
