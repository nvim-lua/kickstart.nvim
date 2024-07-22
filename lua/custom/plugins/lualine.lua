return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'tpope/vim-fugitive' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto',
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          { 'buffers', show_modified_status = true, symbols = { modified = '●', alternate_file = '#', directory = '' } },
        },
        lualine_b = {
          { 'mode', icons_enabled = true },
        },
        lualine_c = {
          'branch',
          { 'diff', colored = false, symbols = { added = ' ', modified = ' ', removed = ' ' } },
        },
        lualine_x = {
          'encoding',
          { 'fileformat', symbols = { unix = ' ', mac = ' ', dos = ' ' } },
          'filetype',
        },
      },
      extensions = { 'fugitive', 'nvim-tree' },
    })
  end,
}

