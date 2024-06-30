return {
  {
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    opts = {},
    config = function(_, opts)
      opts = opts or {}
      require 'lspconfig'

      print(opts)
    end,
  },
}
