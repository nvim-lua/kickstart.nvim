return {
  'mbbill/undotree',
  version = '*',
  lazy = false,
  config = function()
    vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
  end,
}
