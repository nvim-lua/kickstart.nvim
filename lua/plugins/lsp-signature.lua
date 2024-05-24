return {
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {
      select_signature_key = '<M-n>',
    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
}
