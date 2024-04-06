return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local harpoon = require 'harpoon'
    require('dashboard').setup {
      theme = 'doom', --  theme is doom and hyper default is hyper
      disable_move = false,
      config = {
        week_header = {
          enable = true,
        },
        center = {
          {
            icon = '󰊳 ',
            icon_hl = 'group',
            desc = 'Telescope find files',
            desc_hl = 'group',
            key = 'f',
            key_hl = 'group',
            key_format = ' [%s]', -- `%s` will be substituted with value of `key`
            action = ':Telescope find_files',
          },
          {
            icon = '󰊳 ',
            icon_hl = 'group',
            desc = 'Open Harpoon',
            desc_hl = 'group',
            key = 'h',
            key_hl = 'group',
            key_format = ' [%s]', -- `%s` will be substituted with value of `key`
            action = function()
              harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
          },
          {
            icon = '󰊳 ',
            icon_hl = 'group',
            desc = 'Telescope find world',
            desc_hl = 'group',
            key = 'w',
            key_hl = 'group',
            key_format = ' [%s]', -- `%s` will be substituted with value of `key`
            action = ':Telescope live_grep',
          },
          {
            icon = '󰊳 ',
            icon_hl = 'group',
            desc = 'Telescope commits',
            desc_hl = 'group',
            key = 'c',
            key_hl = 'group',
            key_format = ' [%s]', -- `%s` will be substituted with value of `key`
            action = ':Telescope git_commits',
          },
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          },
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
