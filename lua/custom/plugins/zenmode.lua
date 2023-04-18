return {
  "folke/zen-mode.nvim",
  version = "*",
  config = function()
    require("zen-mode").setup {
      window = {
        backdrop = 0.8,
        width = 100,
      },
      plugins = {
        gitsigns = { enabled = false },
      },
    }
  end,
}
