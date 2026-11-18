return {
  { -- Show pending keybinds
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      spec = {
        { '<leader>q', group = 'Quit', mode = { 'n', 'v' } },
      },
    },
  },
}
