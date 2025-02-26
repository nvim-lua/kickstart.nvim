return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    -- debounce = 100,
    indent = {
      char = { '│' },
    },
    whitespace = { highlight = { 'Whitespace', 'NonText' } },
    enabled = true,
  },
}
