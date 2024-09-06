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

    vim.keymap.set('n', '<leader>q', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })

    vim.keymap.set('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = 'Go to buffer [1]' })
    vim.keymap.set('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = 'Go to buffer [2]' })
    vim.keymap.set('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = 'Go to buffer [3]' })
    vim.keymap.set('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = 'Go to buffer [4]' })
    vim.keymap.set('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = 'Go to buffer [5]' })
    vim.keymap.set('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = 'Go to buffer [6]' })
    vim.keymap.set('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = 'Go to buffer [7]' })
    vim.keymap.set('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = 'Go to buffer [8]' })
    vim.keymap.set('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = 'Go to buffer [9]' })
  end,
}
