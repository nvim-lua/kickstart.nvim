return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      priority = 1000,
      lazy = true,
      transparent_background = true,
      custom_highlights = function()
        return {
          Comment = { fg = "#d4922F" },
        }
      end,
    })
  end,
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
