return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'everforest',
      component_separators = '|',
      section_separators = '',
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons'}
}
