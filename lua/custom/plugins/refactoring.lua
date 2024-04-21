return {

  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  init = function()
    local map = vim.api.nvim_set_keymap
    opts = { noremap = true, silent = true }

    map('x', '<leader>Re', ':Refactor extract ', vim.tbl_extend('force', opts, { desc = '[E]xtract buffer' }))
    map('x', '<leader>Rf', ':Refactor extract_to_file ', vim.tbl_extend('force', opts, { desc = 'Extract to [F]ile' }))
    map('x', '<leader>Rv', ':Refactor extract_var ', vim.tbl_extend('force', opts, { desc = 'Extract [V]ariable' }))
    map('n', '<leader>Ri', ':Refactor inline_var', vim.tbl_extend('force', opts, { desc = '[I]nline variable' }))
    map('x', '<leader>Ri', ':Refactor inline_var', vim.tbl_extend('force', opts, { desc = '[I]nline variable' }))
    map('n', '<leader>RI', ':Refactor inline_func', vim.tbl_extend('force', opts, { desc = 'Inline [F]unction' }))
    map('n', '<leader>Rb', ':Refactor extract_block', vim.tbl_extend('force', opts, { desc = 'Extract [B]lock' }))
    map('n', '<leader>Rbf', ':Refactor extract_block_to_file', vim.tbl_extend('force', opts, { desc = 'Extract block to [F]ile' }))
  end,
  config = function()
    require('refactoring').setup()
  end,
}
