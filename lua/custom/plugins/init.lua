-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require 'nvim-tmux-navigation'
      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }
    end,
    keys = {
      { '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', desc = 'Go to the previous pane' },
      { '<C-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'Got to the left pane' },
      { '<C-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'Got to the down pane' },
      { '<C-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'Got to the up pane' },
      { '<C-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'Got to the right pane' },
    },
  },
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-tree/nvim-web-devicons' },

  {
    'utilyre/barbecue.nvim',
    config = function()
      require('barbecue').setup()
    end,
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
  },
  { 'catppuccin/nvim', name = 'catppuccin' },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'github/copilot.vim',
  },
  {
    'tpope/vim-sleuth',
  },
}
