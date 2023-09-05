return {
  'neovim/nvim-lspconfig',
  config = function()
    require('lspconfig').clangd.setup {}
  end
}
