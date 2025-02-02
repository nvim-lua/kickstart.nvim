return {
  'jellydn/typecheck.nvim',
  dependencies = { 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  ft = { 'javascript', 'javascriptreact', 'json', 'jsonc', 'typescript' },
  opts = {
    debug = true,
    mode = 'trouble', -- "quickfix" | "trouble"
  },
  keys = {
    {
      '<leader>st',
      '<cmd>Typecheck<cr>',
      desc = 'Run Type Check',
    },
  },
}
