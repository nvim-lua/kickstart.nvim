return {
  'saecki/crates.nvim',
  tag = 'stable',
  config = function()
    require('crates').setup()
  end,
}
