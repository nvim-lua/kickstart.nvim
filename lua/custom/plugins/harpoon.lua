return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set('n', '<leader>oa', function()
      harpoon:list():add()
    end, { desc = 'Add File' })

    vim.keymap.set('n', '<leader>oi', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open L[I]st' })

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Select [1]' })

    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Select [2]' })

    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Select [3]' })

    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Select [4]' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>oj', function()
      harpoon:list():prev()
    end, { desc = 'Previus File' })

    vim.keymap.set('n', '<leader>ok', function()
      harpoon:list():next()
    end, { desc = 'Next File' })
  end,
}
