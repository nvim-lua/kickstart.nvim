-- Pretty diagnostics / LSP refs / TODO / quickfix lists.
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',                        desc = '[T]rouble diagnostics' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',           desc = '[T]rouble buffer diagnostics' },
    { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>',                desc = '[T]rouble symbols' },
    { '<leader>xr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = '[T]rouble LSP refs/defs' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<cr>',                            desc = '[T]rouble loclist' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                             desc = '[T]rouble quickfix' },
  },
}
