-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>pv', ':Neotree reveal=true position=float<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    window = {
      mappings = {
        ['<c-c>'] = 'close_window',
      },
    },
    source_selector = {
      winbar = true,
      statusline = false,
    },
    -- NOTE: activate this to collapse empty folders -> might cause performance drop
    -- filesystem = {
    --   group_empty_dirs = true,
    --   scan_mode = 'deep',
    -- },
  },
}
