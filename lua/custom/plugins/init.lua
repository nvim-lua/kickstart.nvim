-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  -- themes
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  -- {
  --   'navarasu/onedark.nvim',
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('onedark').setup {
  --       style = 'darker',
  --     }
  --     -- Enable theme
  --     require('onedark').load()
  --   end,
  -- },
  -- { 'marko-cerovac/material.nvim', priority = 1000 },
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    -- opts = {
    --   palette_overrides = {
    --     dark0 = '#282c34',
    --   },
    -- },
    init = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { 'NvChad/nvim-colorizer.lua', opts = {
    user_default_options = {
      css = true,
    },
  } },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
  },
}
