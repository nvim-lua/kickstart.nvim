return {
  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('codeium').setup {
      enable_cmp_source = false, -- disabled because I only want to use virtual text
      virtual_text = {
        enabled = true,
      },
    }
  end,
}
