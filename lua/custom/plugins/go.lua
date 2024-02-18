local M = {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}

function M.config()
  -- setup your go.nvim
  require('go').setup({
    -- lsp_cfg = false,
    -- lsp_keymaps = false, -- disable the lsp keymaps defined by go.nvim. It's true by default
    -- lsp_inlay_hints = {
    --   enable = true,
    --   -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
    --   -- inlay only avalible for 0.10.x
    --   style = 'eol',
    -- },
  })
end

return M
