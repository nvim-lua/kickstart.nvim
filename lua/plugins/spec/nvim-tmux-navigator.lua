-- Tmux navigation integration
return {
  'christoomey/vim-tmux-navigator',
  keys = {
    { '<C-h>', ':TmuxNavigateLeft<CR>', desc = 'Navigate to left tmux pane' },
    { '<C-j>', ':TmuxNavigateDown<CR>', desc = 'Navigate to down tmux pane' },
    { '<C-k>', ':TmuxNavigateUp<CR>', desc = 'Navigate to up tmux pane' },
    { '<C-l>', ':TmuxNavigateRight<CR>', desc = 'Navigate to right tmux pane' },
    { '<C-\\>', ':TmuxNavigatePrevious<CR>', desc = 'Navigate to previous tmux pane' },
  },
}