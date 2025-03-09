return {
  'smoka7/multicursors.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvimtools/hydra.nvim',
  },
  opts = {},
  cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  keys = {
    {
      mode = { 'v', 'n' },
      '<Leader>ms',
      '<cmd>MCstart<cr>',
      desc = 'Create a [M]ulti [S]election for selected text or word under the cursor',
    },
    {
      mode = { 'v', 'n' },
      '<Leader>mp',
      '<cmd>MCpattern<cr>',
      desc = 'Create a [M]ulti [P]attern selection in the current buffer',
    },
  },
}
