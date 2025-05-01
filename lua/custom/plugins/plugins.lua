-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'morhetz/gruvbox',
  'tanvirtin/monokai.nvim',
  'folke/tokyonight.nvim',
  'EdenEast/nightfox.nvim',
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      local api = require 'nvim-tree.api'
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.keymap.set('n', '<leader>st', function()
        api.tree.toggle()
      end, { desc = '[S]earch file tree [T]oggle' })
      require('nvim-tree').setup {
        sort = { sorter = 'case_sensitive' },
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = true },
      }
    end,
  },
}
