local M = {
  'gbprod/substitute.nvim',
  lazy = true,
  event = 'VeryLazy',
}

function M.config()
  require('substitute').setup()
end

vim.api.nvim_set_keymap('n', 's', "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', 'ss', "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', 'S', "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
vim.api.nvim_set_keymap('x', 's', "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

return M
