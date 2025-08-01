return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('harpoon').setup {}
  end,
  keys = {
    {
      '<leader>ha',
      function()
        require('harpoon.mark').add_file()
      end,
      desc = 'Harpoon: Add File',
    },
    {
      '<leader>hr',
      function()
        require('harpoon.mark').rm_file()
      end,
      desc = 'Harpoon: Remove File',
    },
    {
      '<leader>hm',
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
      desc = 'Harpoon: Open Menu',
    },
    {
      '<leader>1',
      function()
        require('harpoon.ui').nav_file(1)
      end,
      desc = 'Harpoon to file 1',
    },
    {
      '<leader>2',
      function()
        require('harpoon.ui').nav_file(2)
      end,
      desc = 'Harpoon to file 2',
    },
    {
      '<leader>3',
      function()
        require('harpoon.ui').nav_file(3)
      end,
      desc = 'Harpoon to file 3',
    },
    {
      '<leader>4',
      function()
        require('harpoon.ui').nav_file(4)
      end,
      desc = 'Harpoon to file 4',
    },
  },
}
