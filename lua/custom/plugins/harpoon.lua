return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- Keymaps
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Mark file' })

    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle quick menu' })

    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: Go to file 1' })

    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: Go to file 2' })

    vim.keymap.set('n', '<C-l>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: Go to file 3' })

    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: Go to file 4' })

    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: Previous buffer' })

    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: Next buffer' })
  end,
}
