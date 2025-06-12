return {
  { -- Add git changes to gutter
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      {
        '<leader>tB',
        function()
          require('gitsigns').toggle_current_line_blame()
        end,
        desc = 'Git [B]lame',
      },
      {
        '<leader>tD',
        function()
          require('gitsigns').toggle_deleted()
        end,
        desc = '[D]eleted git lines',
      },
    },
  },
}
