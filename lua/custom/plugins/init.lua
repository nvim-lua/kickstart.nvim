return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {})
      vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', {})
    end,
  },
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
    keys = {
      {
        '<leader>A',
        function()
          require('harpoon'):list():append()
        end,
        desc = 'harpoon file',
      },
      {
        '<leader>a',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'harpoon quick menu',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'harpoon to file 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'harpoon to file 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'harpoon to file 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'harpoon to file 4',
      },
      {
        '<leader>5',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'harpoon to file 5',
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
    keys = {
      { '<leader>pv', vim.cmd.NvimTreeToggle, desc = 'Toggle nvim-tree' },
    },
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'toggle undotree' },
    },
  },
  { 'github/copilot.vim' },
}
