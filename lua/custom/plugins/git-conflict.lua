return {
  'akinsho/git-conflict.nvim',
  version = '*',
  config = function()
    require('git-conflict').setup {
      default_mappings = true,
      -- co - выбрать Ours (свое)
      -- ct - выбрать Theirs (чужое)
      -- cb - оба
      disable_diagnostics = true,
    }
  end,
}
