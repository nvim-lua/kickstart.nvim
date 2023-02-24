return {
  'romgrk/barbar.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function ()
    vim.keymap.set('', 'J', '<Cmd>BufferPrevious<CR>')
    vim.keymap.set('', 'K', '<Cmd>BufferNext<CR>')
    vim.keymap.set('', 'X', '<Cmd>BufferClose<CR>')
  end
}

