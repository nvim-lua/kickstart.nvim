return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        -- theme = 'everforest',
        icons_enabled = false,
        -- component_separators = { left = '|', right = '|'},
        -- section_separators = { left = '', right = '' },
        path = 1,
      },
    }
  end,
}
