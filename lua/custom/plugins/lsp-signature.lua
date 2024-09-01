-- https://github.com/ray-x/lsp_signature.nvim
return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {
    toggle_key = '<C-g>',
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}
