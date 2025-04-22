return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional, for file icons
  config = function()
    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
        folders_first = true,
        files_first = false,
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    }

    -- Key mapping to toggle NvimTree
    vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
  end,
}
