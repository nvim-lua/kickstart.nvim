local keymap = require 'phoenix.utils.keymap'

return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require("neogen").setup({})

    keymap('n', '<leader>nf', ":lua require('neogen').generate()<CR>")
  end,
}
