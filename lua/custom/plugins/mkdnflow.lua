return {
  'jakewvincent/mkdnflow.nvim',
  config = function()
    require('mkdnflow').setup {
      -- Config goes here; leave blank for defaults
      links = {
        style = 'wiki',
      },
    }
  end,
}
