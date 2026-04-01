return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {
      need = 1,
    },
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = '[Q]uit: restore [S]ession' },
      { '<leader>qS', function() require('persistence').select() end, desc = '[Q]uit: restore [S]ession (picker)' },
      { '<leader>ql', function() require('persistence').load { last = true } end, desc = '[Q]uit: restore [L]ast session' },
      { '<leader>qd', function() require('persistence').stop() end, desc = '[Q]uit: [D]isable session save' },
    },
  },
}
