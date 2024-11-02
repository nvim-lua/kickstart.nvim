return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazygit (Root Dir)' },
    { '<leader>gf', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'Lazygit Current File History' },
    { '<leader>gl', '<cmd>LazyGitFilter<cr>', desc = 'Lazygit log' },
    { '<leader>gb', '<cmd>Gitsigns blame<cr>', desc = 'Git blame' },
    { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'Git Status' },
  },
}
