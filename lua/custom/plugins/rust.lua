return {
  -- Managing crates.io dependencies --
  'saecki/crates.nvim',
  tag = 'stable',
  event = { 'BufRead Cargo.toml' },
  config = function()
    require('crates').setup()
  end,
}
