-- tab 页签
vim.keymap.set('n', 'gb', '<cmd>BufferLinePick<CR>', { desc = '[G]o to [B]uffer' })

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {},
}
