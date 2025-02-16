return {
  -- {
  --   'rmagatti/auto-session',
  --   lazy = false,
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
  --   },
  --   keys = {
  --     -- Will use Telescope if installed or a vim.ui.select picker otherwise
  --     { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
  --     -- { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
  --     -- { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
  --   },
  --   config = function()
  --     require('auto-session').setup {
  --       auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  --     }
  --   end,
  -- },
}
