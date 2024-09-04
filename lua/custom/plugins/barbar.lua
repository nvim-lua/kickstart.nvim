-- https://github.com/romgrk/barbar.nvim
return {
  'romgrk/barbar.nvim',
  enabled = true,
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    },
  },
  config = function(_, opts)
    require('barbar').setup(opts)

    vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = 'Move to next buffer' })
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = 'Move to previous buffer' })

    vim.keymap.set('n', '<leader>bc', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })
  end,
}
