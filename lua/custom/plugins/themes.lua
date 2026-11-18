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
  {
    'loctvl842/monokai-pro.nvim',
    name = 'monokai-pro',
    config = function()
      require('monokai-pro').setup { transparent_background = true }
    end,
  },
  { 'folke/tokyonight.nvim', name = 'tokyonight', priority = 1000, opts = { transparent = true } },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'deparr/tairiki.nvim', name = 'tairiki' },
  { 'sainnhe/sonokai', name = 'sonokai' },
  { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
  { 'vague-theme/vague.nvim', name = 'vague' },
  { 'EdenEast/nightfox.nvim', name = 'nightfox' },
  { 'webhooked/kanso.nvim', name = 'kanso' },
  { 'jacoborus/tender.vim', name = 'tender' },
  { 'projekt0n/github-nvim-theme', name = 'github-theme', priority = 1000 }, -- More info here: https://github.com/projekt0n/github-nvim-theme
}
