return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = '[A]dd to Harpoon list' })
      vim.keymap.set('n', '<leader>e', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Toggle Harpoon m[E]nu' })

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon 4' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>p', function()
        harpoon:list():prev()
      end, { desc = '[P]revious Harpoon' })
      vim.keymap.set('n', '<leader>n', function()
        harpoon:list():next()
      end, { desc = '[N]ext Harpoon' })

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader><S-E>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })
    end,
  },
}
