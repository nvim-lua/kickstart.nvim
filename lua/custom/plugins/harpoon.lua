return {
  'theprimeagen/harpoon',
  --dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Add current file to harpoon' })
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = ' harpoon menu' })
    vim.keymap.set('n', '<C-h>', function()
      ui.nav_file(1)
    end)
    vim.keymap.set('n', '<C-t>', function()
      ui.nav_file(2)
    end)
    vim.keymap.set('n', '<C-n>', function()
      ui.nav_file(3)
    end)
    vim.keymap.set('n', '<C-s>', function()
      ui.nav_file(4)
    end)
  end,
}
