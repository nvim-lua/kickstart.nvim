return {
  {
    'dmmulroy/tsc.nvim',
    lazy = false,
    ft = { 'typescript', 'typescriptreact' },
    config = function()
      require('tsc').setup {
        auto_open_qflist = true,
        pretty_errors = true,
      }
    end,
  },
}
