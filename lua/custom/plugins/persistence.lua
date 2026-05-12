-- Auto session per cwd. Run `:lua require('persistence').load()` to restore
-- the most recent session, or use the keymaps below.
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>qs', function() require('persistence').load() end,                desc = 'Restore session for cwd' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore last session' },
    { '<leader>qd', function() require('persistence').stop() end,                desc = "Don't save current session" },
  },
}
