return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  },
  keys = {
    {
      '<leader>Qs',
      '<Cmd>lua require("persistence").load()<CR>',
      desc = '[L]oad session',
    },
    {
      '<leader>Ql',
      '<Cmd>lua require("persistence").load({ last = true })<CR>',
      desc = '[L]oad last session',
    },
    {
      '<leader>Qq',
      '<Cmd>lua require("persistence").stop()<CR>',
      desc = '[Q]uit session saving',
    },
  },
}
