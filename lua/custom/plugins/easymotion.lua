return {
  'easymotion/vim-easymotion',
  config = function()
    vim.keymap.set('n', '<leader>f', '<Plug>(easymotion-f)', { desc = '[f]ind next character' })
    vim.keymap.set('n', '<leader>F', '<Plug>(easymotion-F)', { desc = '[F]ind previous character' })
    vim.keymap.set('n', '<leader>t', '<Plug>(easymotion-t)', { desc = '[t]ill next character' })
    vim.keymap.set('n', '<leader>T', '<Plug>(easymotion-T)', { desc = '[T]ill previous character' })
  end,
}
