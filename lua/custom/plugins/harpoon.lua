return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end,                 { desc = '[H]arpoon [A]dd file' })
    vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon toggle list' })

    -- Jump to harpoon slots 1..4. (<C-h..> reserved for smart-splits pane nav.)
    for i = 1, 4 do
      vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon slot ' .. i })
    end

    -- Prev/next harpoon entries.
    vim.keymap.set('n', '[h', function() harpoon:list():prev() end, { desc = 'Harpoon prev' })
    vim.keymap.set('n', ']h', function() harpoon:list():next() end, { desc = 'Harpoon next' })
  end,
}
