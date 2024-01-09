return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'ibl',
  opts = {
    exclude = {
      filetypes = { 'dashboard', 'alpha', 'help', 'nvim-tree', 'lazy', 'mason' },
    },
  },
}
