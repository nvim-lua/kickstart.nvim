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
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    close_if_last_window = true, -- Закрывать Neo-tree, если это последнее окно
    popup_border_style = 'rounded', -- Закругленные углы у всплывающих окон

    enable_git_status = true, -- Показ статусов Git
    enable_diagnostics = true, -- Показ диагностик

    filesystem = {
      window = {
        width = 30, -- Ширина окна
        position = 'left',
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
