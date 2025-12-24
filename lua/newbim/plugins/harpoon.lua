-- NOTE: Harpoon2 setup
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- OPTIONAL - you can customize settings here
    -- harpoon:setup({
    --   settings = {
    --     save_on_toggle = true,
    --     sync_on_ui_close = true,
    --     key = function()
    --       return vim.loop.cwd()
    --     end,
    --   },
    -- })

    -- Basic keymaps
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon add file' })

    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon toggle menu' })

    -- Navigation keymaps
    vim.keymap.set('n', '<C-r>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon to file 1' })

    vim.keymap.set('n', '<C-t>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon to file 2' })

    vim.keymap.set('n', '<C-y>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon to file 3' })

    vim.keymap.set('n', '<C-g>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon to file 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon previous buffer' })

    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon next buffer' })

    -- Optional: Telescope integration
    -- If you have telescope installed, you can add this for a better UI
    -- local conf = require('telescope.config').values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require('telescope.pickers')
    --     .new({}, {
    --       prompt_title = 'Harpoon',
    --       finder = require('telescope.finders').new_table {
    --         results = file_paths,
    --       },
    --       previewer = conf.file_previewer {},
    --       sorter = conf.generic_sorter {},
    --     })
    --     :find()
    -- end
    --
    -- vim.keymap.set('n', '<C-e>', function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = 'Open harpoon window' })
  end,
}
