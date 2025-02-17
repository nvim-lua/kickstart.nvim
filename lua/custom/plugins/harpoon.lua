return {
  'ThePrimeagen/harpoon',
  version = '*',
  config = function()
    require('telescope').load_extension 'harpoon'

    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>a', mark.add_file)
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
  end,
}
