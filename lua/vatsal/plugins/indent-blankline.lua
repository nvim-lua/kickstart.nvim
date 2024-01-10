return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  dependencies = { 'HiPhish/rainbow-delimiters.nvim' },
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'ibl',
  opts = {
    scope = { highlight = { 'RainbowDelimiterRed' }, char = '▎', show_start = true },
    exclude = {
      buftypes = { 'dashboard', 'alpha', 'help', 'lazy', 'mason' },
    },
  },
}
