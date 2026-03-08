-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.filetype.add {
  extension = {
    gd = 'gdscript',
  },
}

---@module 'lazy'
---@type LazySpec
return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      -- Add current file to harpoon
      vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = 'Harpoon [A]dd file' })

      -- Toggle harpoon menu
      vim.keymap.set('n', '<leader>hm', ui.toggle_quick_menu, { desc = 'Harpoon [M]enu' })

      -- Navigate to harpooned files (1-9)
      for i = 1, 9 do
        vim.keymap.set('n', '<leader>h' .. i, function() ui.nav_file(i) end, { desc = 'Harpoon go to file ' .. i })
      end

      -- "Alt-Tab" through harpoon files
      vim.keymap.set('n', '<A-l>', ui.nav_next, { desc = 'Harpoon next file' })
      vim.keymap.set('n', '<A-h>', ui.nav_prev, { desc = 'Harpoon previous file' })
    end,
  },
}
