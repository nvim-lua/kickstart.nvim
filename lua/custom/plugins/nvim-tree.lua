return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  version = '*',
  lazy = false,
  config = function()
    require('nvim-tree').setup {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
    }
    -- Keybinding to toggle nvim-tree
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer (nvim-tree)' })
  end,
}
