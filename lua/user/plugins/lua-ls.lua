-- [[ lazydev ]]
-- Teaches lua_ls about the Neovim Lua API and installed plugins when editing
-- this config. Its completion source is registered in completion.lua.

require('lazydev').setup {
  library = {
    -- Load luv (vim.uv) type definitions when `vim.uv` is used
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}
