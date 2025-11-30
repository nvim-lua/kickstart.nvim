return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      contrast = 'medium',
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      bold = true,
    }
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'gruvbox'
  end,
}
