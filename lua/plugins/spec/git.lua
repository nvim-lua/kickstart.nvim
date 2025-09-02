-- Git integration plugins
return {
  -- Fugitive - Git integration
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiff', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse', 'GRemove' },
    keys = {
      { '<leader>gs', '<cmd>Git<cr>', desc = 'Git status' },
      { '<leader>gd', '<cmd>Gdiff<cr>', desc = 'Git diff' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Git commit' },
      { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git blame' },
      { '<leader>gl', '<cmd>Git log<cr>', desc = 'Git log' },
      { '<leader>gp', '<cmd>Git push<cr>', desc = 'Git push' },
      { '<leader>gf', '<cmd>Git fetch<cr>', desc = 'Git fetch' },
    },
  },
  
  -- Gitsigns - Git gutter and hunk operations
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('plugins.config.git').setup_gitsigns()
    end,
  },
}