return  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1001,
  opts = {},
  config = function()
    vim.cmd.colorscheme 'tokyonight-moon'
  end,
}
