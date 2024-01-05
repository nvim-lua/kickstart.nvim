vim.go.tabstop = 2
vim.go.shiftwidth = 2
vim.go.expandtab = true
vim.bo.softtabstop = 2
vim.go.relativenumber = true
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.cmd.colorscheme 'rose-pine' -- Set custom colorscheme [[ NOTE: Never set it to "onedark" cuz it breaks the editor ]]

-- Lualine config
require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = 'auto',
    -- color = { gui = 'bold' },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
