return {
  'ThePrimeagen/harpoon',
  -- No branch needed; defaults to master (Harpoon 1)
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    -- Keymaps for Harpoon 1
    vim.keymap.set('n', '<leader>h', mark.add_file)
    vim.keymap.set('n', '<leader>H', ui.toggle_quick_menu)

    -- Quick Jumps
    vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end)
    vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end)
    -- Add more as needed
  end,
}
