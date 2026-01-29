return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = '┊', -- Thinner/dotted guide
      },
      scope = {
        enabled = false, -- Disabling scope highlight makes it feel less "big"
      },
    },
  },
}
