return {
  'Shatur/neovim-ayu',
--   "folke/tokyonight.nvim",
  priority = 1000,
  -- opts = { style = "night" },
  config = function()
    -- vim.cmd.colorscheme 'tokyonight'
    vim.cmd.colorscheme 'ayu'
  end
}
