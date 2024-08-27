-- https://github.com/ray-x/lsp_signature.nvim
return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('lsp_signature').setup(opts)
    vim.keymap.set('i', '<C-g>', vim.lsp.buf.signature_help, { silent = true, noremap = true, desc = 'toggle function signature' })
  end,
}
