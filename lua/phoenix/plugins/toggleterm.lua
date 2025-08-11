local keymap = require 'phoenix.utils.keymap'

return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<leader>tt]],
      insert_mappings = false,
      direction = 'float',
      shade_terminals = false,
    }

    keymap('n', '<leader>tr', ':ToggleTerm 2 direction=vertical<cr>', { desc = 'Toggle terminal right' })
    keymap('n', '<leader>tb', ':ToggleTerm 3 direction=horizontal<cr>', { desc = 'Toggle terminal bottom' })
  end,
}
