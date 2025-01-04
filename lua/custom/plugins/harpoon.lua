return {
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    },
    config = function()
      local harpoon_ui = require 'harpoon.ui'
      local harpoon_mark = require 'harpoon.mark'

      -- Harpoon keybinds --
      -- Open harpoon ui
      vim.keymap.set('n', '<C-e>', function()
        harpoon_ui.toggle_quick_menu()
      end)

      -- Add current file to harpoon
      vim.keymap.set('n', '<leader>a', function()
        harpoon_mark.add_file()
      end)

      -- Quickly jump to harpooned files
      vim.keymap.set('n', '<leader>1', function()
        harpoon_ui.nav_file(1)
      end)

      vim.keymap.set('n', '<leader>2', function()
        harpoon_ui.nav_file(2)
      end)

      vim.keymap.set('n', '<leader>3', function()
        harpoon_ui.nav_file(3)
      end)

      vim.keymap.set('n', '<leader>4', function()
        harpoon_ui.nav_file(4)
      end)

      vim.keymap.set('n', '<leader>5', function()
        harpoon_ui.nav_file(5)
      end)
    end,
  }
}
