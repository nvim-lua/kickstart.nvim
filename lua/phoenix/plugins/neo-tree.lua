local keymap = require 'phoenix.utils.keymap'

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    {
      -- only needed if you want to use the commands with "_with_window_picker" suffix
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
        require('window-picker').setup {
          hint = 'statusline-winbar',
          selection_chars = 'arstgmneiodh',

          autoselect_one = true,
          include_current_win = false,
          filter_rules = {
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', 'quickfix' },
            },
          },
          -- other_win_hl_color = '#e35e4f',
        }
      end,
    },
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

    require('neo-tree').setup {
      window = {
        position = 'left',
      },
      filesystem = {
        bind_to_cwd = true,
        cwd_target = {
          sidebar = 'window',
          current = 'window',
          float = "window"
        },
        window = {
          mappings = {
            ['o'] = 'open',
          },
        },
      },
    }

    keymap('n', '<leader>kk', ':Neotree toggle reveal_force_cwd position=float<cr>')
    keymap('n', '<leader>kc', ':Neotree toggle position=current<cr>')
    keymap('n', '<leader>kb', ':Neotree toggle reveal position=left<cr>')
    keymap('n', '<leader>kq', ':Neotree close<cr>')
  end,
}
