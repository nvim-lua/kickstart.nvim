return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      require('oil').setup {
        default_file_explorer = true,
      }

      vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open folder structure with Oil' })
    end,
  },
}
