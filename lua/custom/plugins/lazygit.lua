return {
  'kdheepak/lazygit.nvim',
  config = function()
    vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { desc = 'Open lazygit' })
  end,
}
