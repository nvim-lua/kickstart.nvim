--=============================================================================
-- LUA DEV (lazydev.nvim)

-- Improves Lua LSP for Neovim configs/plugins by adding correct library typings and annotations.
--=============================================================================

return {
  'folke/lazydev.nvim', -- used for completion, annotations and signatures of Neovim apis
  ft = 'lua',
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}
