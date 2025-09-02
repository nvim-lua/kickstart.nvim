-- UI and Theme plugins
return {
  -- Color scheme
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Which-key for keybind hints
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('plugins.config.ui').setup_which_key()
    end,
  },

  -- Todo comments highlighting
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
}