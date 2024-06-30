return {
  'ThePrimeagen/harpoon',
  lazy = false,
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('harpoon'):setup()
  end,
  keys = {
    {
      '<C-m>',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Mark file with harpoon',
    },
    {
      '<C-]>',
      function()
        require('harpoon'):list():next()
      end,
      desc = 'Go to next harpoon mark',
    },
    {
      '<C-[>',
      function()
        require('harpoon'):list():prev()
      end,
      desc = 'Go to previous harpoon mark',
    },
    {
      '<C-o>',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = 'Show harpoon marks',
    },
    {
      '<leader>om',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Mark file with harpoon',
    },
    {
      '<leader>o[',
      function()
        require('harpoon'):list():next()
      end,
      desc = 'Go to next harpoon mark',
    },
    {
      '<leader>o]',
      function()
        require('harpoon'):list():prev()
      end,
      desc = 'Go to previous harpoon mark',
    },
    {
      '<leader>oo',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = 'Show harpoon marks',
    },
  },
}

-- Good example of converting commands from normal VIM setup to lazy setup:
--    https://github.com/ThePrimeagen/harpoon/tree/harpoon2
--    https://www.reddit.com/r/neovim/comments/18as0nm/harpoon2_branch_lazy_vim_setup
