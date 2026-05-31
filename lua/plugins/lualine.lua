-- Set lualine as statusline
return {
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'gruvbox',
      component_separators = '|',
      section_separators = '',
    },
  },
}
