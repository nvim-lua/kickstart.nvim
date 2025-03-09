return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = {
    { 'echasnovski/mini.icons', opts = {} },
    { 'nvim-tree/nvim-web-devicons', opts = {} },
  },
  config = function()
    require('oil').setup {
      keymaps = {
        ['<Esc>'] = 'actions.close',
        ['<C-h>'] = false,
      },
    }
  end,
  keys = {
    { '-', '<cmd>Oil --float<cr>', mode = 'n', desc = 'Open Floating Filesystem' },
  },
}
