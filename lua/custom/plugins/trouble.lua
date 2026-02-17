return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {},
  keys = {
    {
      '<leader>xx',
      function()
        require('trouble').toggle 'diagnostics'
      end,
      desc = 'Trouble: all diagnostics',
    },
    {
      '<leader>xw',
      function()
        require('trouble').toggle 'diagnostics'
      end,
      desc = 'Trouble: [W]orkspace diagnostics',
    },
    {
      '<leader>xd',
      function()
        require('trouble').toggle {
          mode = 'diagnostics',
          filter = { buf = 0 },
        }
      end,
      desc = 'Trouble: [D]ocument diagnostics',
    },
    {
      '<leader>xq',
      function()
        require('trouble').toggle 'qflist'
      end,
      desc = 'Trouble: [Q]uickfix list',
    },
    {
      '<leader>xl',
      function()
        require('trouble').toggle 'loclist'
      end,
      desc = 'Trouble: [L]ocation list',
    },
  },
}
