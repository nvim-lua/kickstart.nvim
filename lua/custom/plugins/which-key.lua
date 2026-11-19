return {
  { -- Show pending keybinds
    'folke/which-key.nvim',
    event = 'VimEnter',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer-local keymaps',
      },
    },
    opts = {
      spec = {
        { '<leader>q', group = 'Quit', mode = { 'n', 'v' } },
      },
    },
  },
}
