local keymap = require 'phoenix.utils.keymap'

return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup {}
    -- prompt for a refactor to apply when the remap is triggered
    keymap({ 'n', 'x' }, '<leader>rr', require('refactoring').select_refactor)
  end,
}
