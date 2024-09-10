return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup()
    vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', { noremap = true, desc = 'Toggle file [e]xplorer' })
  end,
}
