-- lazydev.nvim is a plugin that properly configures LuaLS for editing your Neovim config by lazily updating your workspace libraries.
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- the lazydev cmp source is registered in completion.lua
}
