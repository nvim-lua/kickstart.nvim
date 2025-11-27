return {
  'Julian/lean.nvim',
  event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

  dependencies = {
    'nvim-lua/plenary.nvim',
    'Saghen/blink.cmp',
    'nvim-telescope/telescope.nvim',
  },

  ---@type Lean.Config
  opts = {
    mappings = true,
  },
}
