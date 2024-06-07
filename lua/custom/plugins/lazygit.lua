return {
  'kdheepak/lazygit.nvim',
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('telescope').load_extension 'lazygit'
    vim.keymap.set('n', '<leader>gg', '<CMD>:LazyGit<CR>', { desc = 'open lazygit' })
  end,
}
