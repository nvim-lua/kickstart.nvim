-- toggle nvim tree
vim.keymap.set(
  'n',
  '<C-b>',
  require('nvim-tree.api').tree.toggle,
  {
    desc = 'nvim-tree: Toggle tree',
    noremap = true,
    silent = true,
    nowait = true
  }
)
