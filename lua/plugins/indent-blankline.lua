-- Indentation guides for Neovim
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {}, -- Use ibl's defaults for best compatibility

}
