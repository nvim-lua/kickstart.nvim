local config = function()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'rose-pine',
      component_separators = { '|', '|' },
      section_separators = { '', '' },
      disabled_filetypes = {},
    },
    tabline = {},
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  config = config,
}
