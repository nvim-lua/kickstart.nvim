-- In your plugins configuration file (e.g., lua/plugins/catppuccin.lua or similar)
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin', -- Optional, but can be useful for referring to the plugin
    priority = 1000, -- Ensure it loads early to apply the colorscheme
    lazy = false, -- Load on startup if you want it as your default theme
    config = function()
      -- Load the colorscheme here
      -- vim.cmd.colorscheme "catppuccin" -- Default is "mocha" if no flavour is specified

      -- Or, to specify a flavour and set up integrations:
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = false, -- useful if you want the underlying terminal colors to show through
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- Toggles Neovim terminal colors for the Catppuccin palette.
        dim_inactive = {
          enabled = false, -- dims inactive windows
          shade = 'dark',
          percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
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
          -- miscs = {}, -- Custom groups for miscellaneous items specific to firmware development
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please check integration table in the README project
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
          headlines = true,
          indent_blankline = {
            enabled = true,
            scope_color = 'mauve', -- catppuccin color a available flavor
            -- Also a vailable: latte, frappe, macchiato, mocha
          },
        },
      }

      -- After setting up, set the colorscheme
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
