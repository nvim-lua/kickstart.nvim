return {
  -- high-performance color highlighter
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end,
}
