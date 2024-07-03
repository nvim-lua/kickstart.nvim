-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<C-e>', ':Neotree toggle<CR>', { desc = 'NeoTree toggle' } },
    -- { '<leader>e', ':Neotree reveal<CR>', mode = '', desc = '[E]xplore files' },
    -- { '<leader>E', ':Neotree buffers<CR>', mode = '', desc = '[E]xplore buffers' },
  },
  opts = {
    filesystem = {
      window = {},
    },
  },
}
