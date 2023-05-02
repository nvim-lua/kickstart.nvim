return {
  'catppuccin/nvim',
  priority = 1000,
  opts = {
    flavour = 'mocha',
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = true,
    show_end_of_buffer = false, -- show the '~' characetrs after the end of buffers
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = 'dark',
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    styles = {
      booleans = {},
      comments = { 'italic' },
      conditionals = {},
      functions = {},
      keywords = {},
      loops = {},
      numbers = {},
      operators = {},
      properties = {},
      strings = {},
      types = {},
      variables = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      notify = false,
      mini = false,
      -- For more plugins integrations (https://github.com/catppuccin/nvim#integrations)
    }
  },
  config = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}

