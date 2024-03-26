return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = {
          { 'mtime', format = '%y-%m-%d %T' },
          { 'size', highlight = 'Special' },
          'icon',
        },
        view_options = {
          show_hidden = true,
        },
      }
    end,
  },

  vim.keymap.set('n', '<leader>so', ':Oil<CR>'),
}
