return {
  'easymotion/vim-easymotion',
  config = function()
    vim.keymap.set('n', 'f', '<Plug>(easymotion-f)', { desc = '[f]ind next character' })
    vim.keymap.set('n', 'F', '<Plug>(easymotion-F)', { desc = '[F]ind previous character' })
    vim.keymap.set('n', 't', '<Plug>(easymotion-t)', { desc = '[t]ill next character' })
    vim.keymap.set('n', 'T', '<Plug>(easymotion-T)', { desc = '[T]ill previous character' })
  end,
}
