return {
  'echasnovski/mini.nvim',
  version = false,
  require('mini.ai').setup(),
  require('mini.operators').setup(),
  require('mini.surround').setup(),
  require('mini.bracketed').setup(),
  require('mini.files').setup(),
  require('mini.pick').setup(),
  -- require('mini.hues').setup(),
  require('mini.icons').setup(),
  require('mini.statusline').setup(),
}
