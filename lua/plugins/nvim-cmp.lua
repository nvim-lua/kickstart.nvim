return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- 'luckasRanarison/tailwind-tools.nvim',
      'onsails/lspkind-nvim',
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    opts = function()
      return {
        -- ...
        -- formatting = {
        --   format = require('lspkind').cmp_format {
        --     before = require('tailwind-tools.cmp').lspkind_format,
        --   },
        -- },
      }
    end,
  },
}
