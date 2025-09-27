-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>nn', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
    { '<leader>na', ':Neotree filesystem create<CR>', desc = 'NeoTree create file', silent = true },
    { '<leader>nd', ':Neotree filesystem create<CR>', desc= 'NeoTree create directory', silent = true },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['a'] = 'add',
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
        },
      },
    },
  },
}
