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
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.api.nvim_create_autocmd('BufReadPost', {
        callback = function(data)
          local api = require 'nvim-tree.api'
          api.tree.open()
        end,
      })
      require('nvim-tree').setup {
        sort = { sorter = 'case_sensitive' },
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = true },
      }
    end,
  },
}
