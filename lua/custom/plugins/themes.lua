return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'macchiato',
      transparent_background = true,
      term_colors = true,
      custom_highlights = function(colors)
        return {
          Comment = { fg = colors.overlay0 },
          TabLineSel = { bg = colors.teal },
          CmpBorder = { fg = colors.surface2 },
          StatusLine = { fg = colors.blue },
          GetFile = { fg = colors.blue },
        }
      end,
    },
  },
  { 'folke/tokyonight.nvim', name = 'tokyonight', priority = 1000, opts = { transparent = true } },
}
