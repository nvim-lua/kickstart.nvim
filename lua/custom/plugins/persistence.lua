return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals' },
  },
  keys = {
    {
      '<leader>wr',
      function()
        require('persistence').load()
      end,
      desc = '[W]orkspace [R]estore session',
    },
    {
      '<leader>wl',
      function()
        require('persistence').load { last = true }
      end,
      desc = '[W]orkspace [L]ast session',
    },
    {
      '<leader>wd',
      function()
        require('persistence').stop()
      end,
      desc = '[W]orkspace [D]isable session save',
    },
  },
}
