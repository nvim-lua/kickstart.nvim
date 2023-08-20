local options = {
  icons_enabled = false,
  component_separators = '|',
  section_separators = '',
  disabled_filetypes = {},
  always_divide_middle = true,
  globalstatus = false,
}

local sections = {
  lualine_a = { 'mode' },
  lualine_b = { 'branch', 'diff', 'diagnostics' },
  lualine_c = { '%f', '[%-m]', 'filesize' },
  lualine_x = { 'encoding', 'fileformat', 'filetype' },
  lualine_y = { 'progress' },
  lualine_z = { 'location' },
}

local inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { 'filename' },
  lualine_x = { 'location' },
  lualine_y = { 'test' },
  lualine_z = {},
}

local tabline = {}

local extensions = {}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts, { ['options'] = options })
      table.insert(opts, { ['sections'] = sections })
      table.insert(opts, { ['tabline'] = tabline })
      table.insert(opts, { ['extensions'] = extensions })
    end,
  },
}
