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
    -- { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'open_default',
      window = {
        mappings = {
          ['<leader>tt'] = 'close_window',
        },
      },
    },
  },

  vim.keymap.set('n', '<leader>tt', '<Cmd>Neotree toggle<CR>', { desc = '[T]oggle [T]ree' }),
}
