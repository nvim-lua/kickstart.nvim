return {
  'MagicDuck/grug-far.nvim',
  cmd = { 'GrugFar', 'GrugFarWithin' },
  opts = {},
  keys = {
    {
      '<leader>sR',
      function()
        require('grug-far').open {
          prefills = {
            search = vim.fn.expand '<cword>',
          },
        }
      end,
      mode = 'n',
      desc = '[S]earch project [R]eplace',
    },
    {
      '<leader>sR',
      function()
        require('grug-far').with_visual_selection()
      end,
      mode = 'x',
      desc = '[S]earch project [R]eplace selection',
    },
  },
}
