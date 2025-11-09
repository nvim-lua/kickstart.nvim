--keymap reset
vim.keymap.del('i', '<Tab>')
vim.keymap.del('i', '<S-Tab>')

--dart
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dart',
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})
--dart run
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dart',
  callback = function()
    vim.keymap.set('n', '<S-F10>', ':!dart run --enable-asserts %<CR>', { desc = 'Run Dart file' })
  end,
})
--LSP Menu
vim.keymap.set('n', '<leader>ca', function()
  vim.lsp.buf.code_action {
    apply = false,
  }
end, { desc = 'Quick fix (Dart LSP)' })
