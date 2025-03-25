return {
  'Dan7h3x/neaterm.nvim',
  branch = 'stable',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      toggle = '<leader>tt',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ibhagwan/fzf-lua',
  },
}
