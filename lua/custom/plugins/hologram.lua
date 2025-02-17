return {
  'edluffy/hologram.nvim',
  version = '*',
  config = function()
    require('hologram').setup {
      auto_display = true,
    }
  end,
}
