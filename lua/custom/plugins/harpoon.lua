return {
  'ThePrimeagen/harpoon',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = true,
  keys = {
    { '<C-m>', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = 'Mark file with harpoon' },
    { '<C-]>', "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = 'Go to next harpoon mark' },
    { '<C-[>', "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = 'Go to previous harpoon mark' },
    { '<C-o>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = 'Show harpoon marks' },
    { '<leader>om', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = 'Mark file with harpoon' },
    { '<leader>o[', "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = 'Go to next harpoon mark' },
    { '<leader>o]', "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = 'Go to previous harpoon mark' },
    { '<leader>oo', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = 'Show harpoon marks' },
  },
}
