vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dart',
  callback = function()
    vim.keymap.set('n', '<S-F10>', ':!dart run %<CR>', { desc = 'Run Dart file' })
  end,
})
