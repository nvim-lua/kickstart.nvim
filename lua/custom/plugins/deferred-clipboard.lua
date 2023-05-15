
return {
  'EtiamNullam/deferred-clipboard.nvim',
  config = function()
    require('deferred-clipboard').setup {
    fallback = 'unnamedplus', -- or your preferred setting for clipboard
    }
  end,
}
