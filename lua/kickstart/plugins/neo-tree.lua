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
    { '\\', ':Neotree reveal position=float<CR>', desc = 'NeoTree reveal in float mode', silent = true },
    { '<leader>nds', ':Neotree document_symbols position=float<CR>', desc = 'NeoTree document symbols', silent = true },
  },
  opts = {
    sources = {
      'filesystem',
      'document_symbols',
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      follow_current_file = {
        enabled = true,
      },
    },
  },
}
