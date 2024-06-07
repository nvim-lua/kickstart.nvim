return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        vim.env.HOME .. '.local/share/nvim/lazy/luvit-meta/library/',
        -- You can also add plugins you always want to have loaded.
        -- Useful if the plugin has globals or types you want to use
        -- vim.env.LAZY .. "/LazyVim", -- see below
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
