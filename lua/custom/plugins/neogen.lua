return {
  'danymat/neogen',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'L3MON4D3/LuaSnip',
  },
  keys = {
    {
      '<leader>nf',
      function()
        require('neogen').generate({ type = 'func' })
      end,
      desc = 'Generate function doc',
    },
    {
      '<leader>nt',
      function()
        require('neogen').generate({ type = 'type' })
      end,
      desc = 'Generate type doc',
    },
  },
  config = function()
    require('neogen').setup({
      snippet_engine = 'luasnip',
    })
  end,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
