--
-- Codeium
-- https://github.com/Exafunction/codeium.nvim
--

return {

  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  event = 'BufEnter',
  config = function()
    require('codeium').setup {}
  end,
}
