-- return {
--   {
--     "nvim-lualine/lualine.nvim",
--     dependencies = {
--       'nvim-tree/nvim-web-devicons',
--     },
--     config = function()
--       require("lualine").setup({
--         options = {
--           theme = "catppuccin",
--           icons_enabled = true,
--           section_separators = '',
--           component_separators = '',
--         },
--         sections = {
--           lualine_a = {
--             "mode",
--             "buffers",
--           },
--           lualine_c = {},
--         },
--       })
--     end,
--   },
-- }

return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          --section_separators = { left = '', right = '' },
          section_separators = { left = ' ', right = ' '},
        },
        sections = {
          lualine_a = {
            "mode",
            "buffers",
          },
          lualine_c = {},
        }
      })
    end
  },
}
