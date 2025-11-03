return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      indent = {
        char = '▏', -- Thinner character (alternatives: '│', '┊', '┆', '¦', '|', '⁞')
        smart_indent_cap = true,
      },
      scope = {
        enabled = false, -- Disable scope highlighting
        show_start = false,
        show_end = false,
      },
    },
  },
}
