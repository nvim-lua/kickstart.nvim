return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false

      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      map('n', '<tab>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<S-tab>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<leader>xx', '<Cmd>BufferClose<CR>', vim.tbl_extend('force', opts, { desc = '[X] Close buffer' }))
      map('n', '<leader>xl', '<Cmd>BufferCloseBuffersLeft<CR>', vim.tbl_extend('force', opts, { desc = '[L] Close all buffers left' }))
      map('n', '<leader>xr', '<Cmd>BufferCloseBuffersRight<CR>', vim.tbl_extend('force', opts, { desc = '[R] Close all buffers right' }))
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
