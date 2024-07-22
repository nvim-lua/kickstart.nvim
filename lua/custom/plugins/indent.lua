return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  main = 'ibl',
  opts = {
    indent = {
      --[[ highlight = highlight ]]
      char = '┆',
      -- char = ' ',
      -- char = "│",
      -- smart_indent_cap = true,
    },
    whitespace = {
      --[[ highlight = highlight, ]]
      remove_blankline_trail = false,
    },
    scope = { enabled = true },
  },
}

