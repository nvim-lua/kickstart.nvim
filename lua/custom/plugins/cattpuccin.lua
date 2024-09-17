-- Catppuccin is a Neovim theme plugin with flexible color schemes
-- https://github.com/catppuccin/nvim

return {
  'catppuccin/nvim', -- GitHub repository
  as = 'catppuccin', -- Optional: rename the plugin to 'catppuccin'
  version = '*', -- Use the latest version
  dependencies = {
    'kyazdani42/nvim-web-devicons', -- Recommended for file icons
  },
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe', -- Choose from "latte", "frappe", "macchiato", "mocha"
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false,
      show_end_of_buffer = true,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.15,
      },
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = 'auto',
        },
      },
    }

    -- Set the colorscheme
    vim.cmd 'colorscheme catppuccin'
  end,
}


