return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<C-g>', '<cmd>LazyGit<cr>', mode = { 'n', 'v' }, desc = 'LazyGit' },
    { '<C-g>', 'q', mode = { 't' }, desc = 'Close LazyGit' },
    { '<esc>', '[[<C-><C-n>]]', mode = { 't' }, desc = 'Close LazyGit' },
  },
}
