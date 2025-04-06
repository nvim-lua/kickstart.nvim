local colors = require('gruvbox-material.colors').get(vim.o.background, 'hard')

require('gruvbox-material').setup {
  italics = false, -- enable italics in general
  contrast = 'hard', -- set contrast, can be any of "hard", "medium", "soft"
  comments = {
    italics = false,
  },
  background = {
    transparent = true, -- set the background to transparent
  },
  float = {
    force_background = false, -- force background on floats even when background.transparent is set
    background_color = nil, -- set color for float backgrounds. If nil, uses the default color set
    -- by the color scheme
  },
  signs = {
    highlight = true, -- whether to highlight signs
  },
  customize = function(group, opt)
    if group == '@type' then
      opt.link = nil
      opt.fg = colors.blue
    end

    if string.find(group, '.macro') then
      opt.link = nil
      opt.fg = colors.purple
    end

    if string.find(group, '@variable') then
      opt.link = nil
      opt.fg = nil
    end

    if group == '@string' then
      opt.link = nil
      opt.fg = colors.yellow
    end

    if group == '@keyword.modifier' then
      opt.link = nil
      opt.fg = colors.orange
    end

    if group == '@string.escape' then
      opt.link = nil
      opt.fg = colors.aqua
    end

    if group == '@property' then
      opt.link = nil
      opt.fg = nil
    end

    if group == '@module' then
      opt.link = nil
      opt.fg = colors.aqua
    end

    return opt
  end,
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

require('ibl').setup {
  indent = {
    char = '▏',
  },
}

vim.api.nvim_set_hl(0, 'CursorNormal', { bg = colors.green })
vim.api.nvim_set_hl(0, 'CursorInsert', { bg = colors.red })
vim.api.nvim_set_hl(0, 'CursorVisual', { bg = colors.purple })
vim.api.nvim_set_hl(0, 'CursorCommand', { bg = colors.blue })
vim.opt.guicursor = {
  'n:block-CursorNormal-blinkwait1000-blinkon100-blinkoff100',
  'i:block-CursorInsert-blinkwait1000-blinkon100-blinkoff100',
  'v:block-CursorVisual-blinkwait1000-blinkon100-blinkoff100',
  'c-ci-cr:block-CursorCommand-blinkwait1000-blinkon100-blinkoff100',
}
