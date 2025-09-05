local M = {}

function M.setup()
  local harpoon = require 'harpoon'
  harpoon:setup {
    settings = {
      save_on_toggle = false,
      sync_on_ui_close = false,
      key = function()
        return vim.loop.cwd()
      end,
    },
  }

  -- Add current file to list
  vim.keymap.set('n', '<leader>ma', function()
    harpoon:list():add()
    vim.notify('Added to Harpoon', vim.log.levels.INFO)
  end, { desc = '[M]ark [A]dd file (Harpoon)' })

  -- Toggle quick menu
  vim.keymap.set('n', '<C-e>', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = 'Toggle Harpoon menu' })

  -- Quick navigation to files 1-4 using leader+m prefix
  vim.keymap.set('n', '<leader>m1', function()
    harpoon:list():select(1)
  end, { desc = 'Jump to mark 1' })

  vim.keymap.set('n', '<leader>m2', function()
    harpoon:list():select(2)
  end, { desc = 'Jump to mark 2' })

  vim.keymap.set('n', '<leader>m3', function()
    harpoon:list():select(3)
  end, { desc = 'Jump to mark 3' })

  vim.keymap.set('n', '<leader>m4', function()
    harpoon:list():select(4)
  end, { desc = 'Jump to mark 4' })

  -- Alternative quick access with Alt/Option key (doesn't conflict)
  vim.keymap.set('n', '<M-1>', function()
    harpoon:list():select(1)
  end, { desc = 'Harpoon file 1' })

  vim.keymap.set('n', '<M-2>', function()
    harpoon:list():select(2)
  end, { desc = 'Harpoon file 2' })

  vim.keymap.set('n', '<M-3>', function()
    harpoon:list():select(3)
  end, { desc = 'Harpoon file 3' })

  vim.keymap.set('n', '<M-4>', function()
    harpoon:list():select(4)
  end, { desc = 'Harpoon file 4' })

  -- Navigate between harpoon files
  vim.keymap.set('n', '[m', function()
    harpoon:list():prev()
  end, { desc = 'Previous marked file' })

  vim.keymap.set('n', ']m', function()
    harpoon:list():next()
  end, { desc = 'Next marked file' })

  -- Show harpoon files in Telescope
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

  vim.keymap.set('n', '<leader>mm', function()
    toggle_telescope(harpoon:list())
  end, { desc = '[M]arked files in Telescope' })

  -- Clear all marks
  vim.keymap.set('n', '<leader>mc', function()
    harpoon:list():clear()
    vim.notify('Cleared all Harpoon marks', vim.log.levels.INFO)
  end, { desc = '[M]arks [C]lear all' })

  -- Remove current file from harpoon
  vim.keymap.set('n', '<leader>mr', function()
    harpoon:list():remove()
    vim.notify('Removed from Harpoon', vim.log.levels.INFO)
  end, { desc = '[M]ark [R]emove current file' })
end

return M