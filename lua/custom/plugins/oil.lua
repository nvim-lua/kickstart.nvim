-- return {
--   'stevearc/oil.nvim',
--   config = function()
--     require('oil').setup()
--     vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
--   end,
-- }

vim.pack.add { 'https://github.com/stevearc/oil.nvim' }
require('oil').setup {
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
}
