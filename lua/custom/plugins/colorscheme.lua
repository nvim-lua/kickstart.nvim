-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false,
--     priority = 1000,
--
--     config = function()
--       require("catppuccin").setup({
--         flavour = "mocha",
--         transparent_background = true,
--       })
--       vim.cmd.colorscheme 'catppuccin'
--     end,
--   }
-- }

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'moon',
      }
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
}
