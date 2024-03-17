-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',

    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      vim.keymap.set({ 'n' }, '<leader>a', function()
        harpoon:list():append()
      end, { desc = '[A]ppend File to harpoon' })
      vim.keymap.set('n', '<C-h>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[H]arpoon quick menu' })

      vim.keymap.set('n', '<C-s>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-t>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-g>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-b>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-p>', function()
        harpoon:list():next()
      end)
      vim.keymap.set('n', '<C-n>', function()
        harpoon:list():prev()
      end)
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

      vim.keymap.set('n', '<C-e>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })
    end,
  },
  {
    'ellisonleao/carbon-now.nvim',
    lazy = true,
    cmd = 'CarbonNow',
    -- @param opts cn.ConfigSchema
    opts = {
      base_url = 'https://carbon.now.sh/',
      open_cmd = 'xdg-open',
      options = {
        bg = 'gray',
        drop_shadow_blur = '68px',
        drop_shadow = false,
        drop_shadow_offset_y = '20px',
        font_family = 'JetBrains Mono',
        font_size = '16px',
        line_height = '124%',
        line_numbers = true,
        theme = 'verminal',
        titlebar = 'Made with carbon-now.nvim',
        watermark = false,
        width = '680',
        window_theme = 'sharp',
        padding_horizontal = '0px',
        padding_vertical = '0px',
      },
    },
  },
}
