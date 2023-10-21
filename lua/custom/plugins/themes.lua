return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
    },
  },
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  -- Set lualine as statusline
  --   'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  --   opts = {
  --     options = {
  --       icons_enabled = true,
  --  theme = 'catppuccin-mocha',
  --       theme = 'tokyonight',
  -- section_separators = { left = '', right = '' },
  -- component_separators = { left = '', right = '' }
  --     },
  --   },
  -- },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
}
