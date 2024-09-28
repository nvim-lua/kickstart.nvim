return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },

  init = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    local map = vim.keymap.set

    map('n', '<leader>a', function()
      harpoon:list():add()
    end)
    map('n', '<C-a>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    map('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = '[Harpoon] Go to first buffer saved' })

    map('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = '[Harpoon] Go to second buffer saved' })

    map('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = '[Harpoon] Go to third buffer saved' })

    map('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = '[Harpoon] Go to forth buffer saved' })

    map('n', '<leader>5', function()
      harpoon:list():select(5)
    end, { desc = '[Harpoon] Go to forth buffer saved' })

    map('n', '<leader>6', function()
      harpoon:list():select(6)
    end, { desc = '[Harpoon] Go to forth buffer saved' })

    map('n', '<leader>7', function()
      harpoon:list():select(7)
    end, { desc = '[Harpoon] Go to forth buffer saved' })

    map('n', '<leader>8', function()
      harpoon:list():select(8)
    end, { desc = '[Harpoon] Go to forth buffer saved' })

    map('n', '<leader>9', function()
      harpoon:list():select(9)
    end, { desc = '[Harpoon] Go to forth buffer saved' })
  end,
}
