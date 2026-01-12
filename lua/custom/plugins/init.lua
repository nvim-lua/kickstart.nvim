-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Git integration in nvim
  'tpope/vim-fugitive',

  -- Supermaven integration
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_word = '<C-Tab>',
          accept_suggestion = '<C-j>',
        },
      }
    end,
  },

  -- Harpoon, for quick file navigation
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader><Tab>', function()
        harpoon:list():add()
      end)

      vim.keymap.set('n', '<leader>H', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end)

      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end)

      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end)

      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end)

      vim.keymap.set('n', '<leader>5', function()
        harpoon:list():select(5)
      end)

      -- Go back to the previous buffer
      vim.keymap.set('n', '<leader>`', '<cmd>b#<CR>')

      local harpoon_extensions = require 'harpoon.extensions'
      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    end,
  },

  -- Breadcrumbs
  {
    "SmiteshP/nvim-navic",
    dependencies = 'neovim/nvim-lspconfig',
  },
}
-- vim: ts=2 sts=2 sw=2 et
