return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',
  },
  keys = {
    { '<C-f>', '<cmd>Neotree toggle<cr>', desc = '[F]iles with Neotree' },
    --    config = function()
    --      require("neo-tree").setup()
    --    end,
  },
}
