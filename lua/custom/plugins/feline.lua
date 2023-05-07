return {
  'feline-nvim/feline.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = function()
    require('feline').setup()
  end,
}
