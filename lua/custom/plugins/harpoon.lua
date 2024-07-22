return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to harpoon' })
    vim.keymap.set('n', '<c-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open harpoon window' })
    -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon.list()) end, { desc = "Open harpoon window" })

    vim.keymap.set('n', '<c-h>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<c-t>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<c-n>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<c-s>', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<c-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<c-S-N>', function()
      harpoon:list():next()
    end)
  end,
}

