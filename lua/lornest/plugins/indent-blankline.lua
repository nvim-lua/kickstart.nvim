return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = { char = '┊' },
    scope = {
      enabled = true,
      highlight = { "Function", "Label" },
    },
  },
}
