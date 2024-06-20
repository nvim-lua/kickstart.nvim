return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      'css',
      'scss',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'html',
    })
  end,
}
