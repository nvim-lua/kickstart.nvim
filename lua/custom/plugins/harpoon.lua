return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = false,
    config = function()
      require('harpoon'):setup({})
    end,
    keys = {
      {
        '<leader>a',
        function()
          require('harpoon'):list():add()
        end,
        mode = 'n',
        desc = '[A]dd to Harpoon',
      },
      {
        '<C-e>',
        function()
          local files = require('harpoon'):list() or {}
          require('harpoon').ui:toggle_quick_menu(files)
        end,
        desc = 'Toggle Harpoon [E]xplorer',
      },
    },
}

