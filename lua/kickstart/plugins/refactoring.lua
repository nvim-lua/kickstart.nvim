return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- require('refactoring').setup()
      local refactoring = require 'refactoring'
      refactoring:setup()

      vim.keymap.set('x', '<leader>re', ':Refactor extract ')
      vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ')
      vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var')
      vim.keymap.set('n', '<leader>rI', ':Refactor inline_func')
      vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ')
    end,
  },
}
