return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      vim.g.barbar_auto_setup = false
      map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
      map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<leader>xx', '<Cmd>BufferClose<CR>', opts)
      map('n', '<leader>xl', '<Cmd>BufferCloseBuffersRight<CR>', opts)
      map('n', '<leader>xh', '<Cmd>BufferCloseBuffersLeft<CR>', opts)
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
