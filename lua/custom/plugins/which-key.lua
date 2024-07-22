return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    windows = {
      border = 'single',
    },
  },
}

