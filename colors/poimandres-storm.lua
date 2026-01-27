-- Poimandres Storm (Neovim)
-- Based on Poimandres Storm by Oliver Cederborg

vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd 'syntax reset'
end

vim.o.termguicolors = true
vim.g.colors_name = 'poimandres-storm'

-- Expanded palette
local colors = {
  -- Accents
  yellow = '#FFFAC2',

  teal1 = '#5DE4C7',
  teal2 = '#5FB3A1',
  teal3 = '#42675A',

  blue1 = '#89DDFF',
  blue2 = '#ADD7FF',
  blue3 = '#91B4D5',
  blue4 = '#7390AA',

  pink1 = '#FAE4FC',
  pink2 = '#FCC5E9',
  pink3 = '#D0679D',

  -- Neutrals
  blueGray1 = '#A6ACCD',
  blueGray2 = '#767C9D',
  blueGray3 = '#506477',

  -- Background layers
  bg = '#252B37', -- main editor
  bg_alt = '#1B1E28', -- floats / panels
  bg_dark = '#171922', -- deepest contrast

  -- Text
  fg = '#E4F0FB',
  white = '#FFFFFF',

  none = 'NONE',
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ======================
-- Core UI
-- ======================
hi('Normal', { fg = colors.fg, bg = colors.bg })
hi('NormalFloat', { fg = colors.fg, bg = colors.bg_alt })
hi('FloatBorder', { fg = colors.blueGray3, bg = colors.bg_alt })

hi('Cursor', { fg = colors.bg, bg = colors.blueGray1 })
hi('CursorLine', { bg = colors.bg_alt })
hi('CursorLineNr', { fg = colors.blue1, bold = true })
hi('LineNr', { fg = colors.blueGray3 })

hi('Visual', { bg = colors.blueGray3 })
hi('Search', { fg = colors.bg, bg = colors.yellow })
hi('IncSearch', { fg = colors.bg, bg = colors.pink2 })

hi('StatusLine', { fg = colors.fg, bg = colors.bg_alt })
hi('StatusLineNC', { fg = colors.blueGray2, bg = colors.bg_alt })

hi('WinSeparator', { fg = colors.bg_alt })
hi('VertSplit', { fg = colors.bg_alt })

-- ======================
-- Menus
-- ======================
hi('Pmenu', { fg = colors.fg, bg = colors.bg_alt })
hi('PmenuSel', { fg = colors.bg, bg = colors.blue1 })
hi('PmenuSbar', { bg = colors.bg_dark })
hi('PmenuThumb', { bg = colors.blueGray3 })

-- ======================
-- Syntax
-- ======================
hi('Comment', { fg = colors.blueGray3, italic = true })

hi('Constant', { fg = colors.pink2 })
hi('String', { fg = colors.teal1 })
hi('Character', { fg = colors.teal1 })
hi('Number', { fg = colors.pink2 })
hi('Boolean', { fg = colors.pink3 })

hi('Identifier', { fg = colors.blue1 })
hi('Function', { fg = colors.blue1 })

hi('Statement', { fg = colors.pink3 })
hi('Keyword', { fg = colors.pink3 })
hi('Conditional', { fg = colors.pink3 })
hi('Repeat', { fg = colors.pink3 })
hi('Exception', { fg = colors.pink3 })

hi('Type', { fg = colors.yellow })
hi('StorageClass', { fg = colors.yellow })
hi('Structure', { fg = colors.yellow })

hi('Operator', { fg = colors.teal2 })
hi('Delimiter', { fg = colors.blueGray2 })

-- ======================
-- Diagnostics (LSP)
-- ======================
hi('DiagnosticError', { fg = colors.pink3 })
hi('DiagnosticWarn', { fg = colors.yellow })
hi('DiagnosticInfo', { fg = colors.blue2 })
hi('DiagnosticHint', { fg = colors.teal2 })

hi('DiagnosticVirtualTextError', { fg = colors.pink3, bg = colors.bg_dark })
hi('DiagnosticVirtualTextWarn', { fg = colors.yellow, bg = colors.bg_dark })
hi('DiagnosticVirtualTextInfo', { fg = colors.blue2, bg = colors.bg_dark })
hi('DiagnosticVirtualTextHint', { fg = colors.teal2, bg = colors.bg_dark })

-- ======================
-- Git / Diff
-- ======================
hi('DiffAdd', { fg = colors.teal1 })
hi('DiffChange', { fg = colors.yellow })
hi('DiffDelete', { fg = colors.pink3 })

-- ======================
-- Tabs
-- ======================
hi('TabLine', { fg = colors.blueGray2, bg = colors.bg_alt })
hi('TabLineSel', { fg = colors.fg, bg = colors.bg_alt, bold = true })
hi('TabLineFill', { bg = colors.bg_alt })
