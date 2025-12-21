-- return {
--   'fguisso/sfer.nvim',
-- }
vim.keymap.set('n', 'fs', '<cmd>SarifView<CR>')
vim.keymap.set('n', '<M-i>', '<cmd>SarifCodeFlowNext<CR>')
vim.keymap.set('n', '<M-o>', '<cmd>SarifCodeFlowPrev<CR>')

return {
  'bhendo/sarif.nvim',
}
