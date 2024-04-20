return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 50,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    }
    vim.keymap.set({ 'n' }, '<leader>st', ':NvimTreeFindFile<CR>', { desc = '[S]earch [T]ree' })
    vim.keymap.set({ 'n' }, 'xx', ':NvimTreeFindFileToggle<CR>', { desc = '[C]lose NvimTree' })
  end,
}
