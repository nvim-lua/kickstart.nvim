return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local nvimtree = require 'nvim-tree'
      local nvimtreeApi = require 'nvim-tree.api'

      nvimtree.setup {
        view = {
          width = 35,
        },
        -- change folder arrow icons
        renderer = {
          highlight_modified = 'all',
          highlight_git = true,

          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = '', -- arrow when folder is closed
                arrow_open = '', -- arrow when folder is open
              },
              git = {
                -- unstaged = "✗",
                -- staged = "✓",
                -- unmerged = "",
                -- renamed = "➜",
                untracked = '',
                -- deleted = "",
                ignored = '',
              },
            },
          },
        },
        -- disable window_picker for
        -- explorer to work well with
        -- window splits
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          custom = { '.DS_Store' },
        },
        git = {
          ignore = false,
        },
      }

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' }) -- toggle file explorer
      -- keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file explorer on current file' }) -- toggle file explorer on current file
      -- keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' }) -- collapse file explorer
      -- keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' }) -- refresh file explorer

      vim.api.nvim_create_autocmd('BufEnter', { callback = require('clowiie.utils.ui').treefocus })
    end,
  },
}
