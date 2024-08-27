return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-h>', '<cmd>TmuxNavigateLeft<cr>' },
    { '<c-j>', '<cmd>TmuxNavigateDown<cr>' },
    { '<c-k>', '<cmd>TmuxNavigateUp<cr>' },
    { '<c-l>', '<cmd>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
