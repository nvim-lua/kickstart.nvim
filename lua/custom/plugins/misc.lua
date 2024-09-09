return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  -- {
  --   -- sessions
  --   'folke/persistence.nvim',
  --   event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  --   opts = {
  --     -- load the session for the current directory
  --     vim.keymap.set('n', '<leader>Ss', function()
  --       require('persistence').load()
  --     end, { desc = 'Load session from directory' }),
  --
  --     -- select a session to load
  --     vim.keymap.set('n', '<leader>SS', function()
  --       require('persistence').select()
  --     end, { desc = 'Select a sesion to load' }),
  --
  --     -- load the last session
  --     vim.keymap.set('n', '<leader>Sl', function()
  --       require('persistence').load { last = true }
  --     end, { desc = 'Load the last session' }),
  --
  --     -- stop Persistence => session won't be saved on exit
  --     vim.keymap.set('n', '<leader>Sd', function()
  --       require('persistence').stop()
  --     end, { desc = 'Stop Saving sessions' }),
  --     -- add any custom options here
  --   },
  -- },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
    end,
  },
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
  {
    'stevearc/resession.nvim',
    -- opts = {
    config = function()
      local resession = require 'resession'
      resession.setup()
      -- Resession does NOTHING automagically, so we have to set up some keymaps
      vim.keymap.set('n', '<leader>Ss', resession.save, { desc = 'Save Session' })
      vim.keymap.set('n', '<leader>Sl', resession.load, { desc = 'Load Session' })
      vim.keymap.set('n', '<leader>Sd', resession.delete, { desc = 'Delete Session' })

      vim.api.nvim_create_autocmd('VimLeavePre', {
        callback = function()
          -- Always save a special session named "last"
          resession.save 'last'
        end,
      })
    end,
    -- },
  },
}
