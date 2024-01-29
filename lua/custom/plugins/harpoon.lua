local M = {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap('n', '<M-a>', "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
  keymap('n', '<M-f>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
  keymap('n', '<C-h>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
  keymap('n', '<C-j>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
  keymap('n', '<C-k>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", opts)
  keymap('n', '<C-l>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", opts)
end

return M
