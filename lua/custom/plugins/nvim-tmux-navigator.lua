return {
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { desc = 'Navigate to left tmux pane' })
      vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { desc = 'Navigate to lower tmux pane' })
      vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { desc = 'Navigate to upper tmux pane' })
      vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { desc = 'Navigate to right tmux pane' })
    end,
  },
}
