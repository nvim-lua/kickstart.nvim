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

-- copy file path
--
-- " full path
-- :let @+ = expand("%:p")
vim.keymap.set('n', '<leader>cbp', ':let @+ = expand("%:p")<CR>', {
  desc = "[C]opy [B]uffer [P]ath"
})

-- " relative path
-- :let @+ = expand("%")
vim.keymap.set('n', '<leader>cbr', ':let @+ = expand("%")<CR>', {
  desc = "[C]opy [B]uffer [R]elative path"
})

-- " just filename
-- :let @+ = expand("%:t")
vim.keymap.set('n', '<leader>cbn', ':let @+ = expand("%:t")<CR>', {
  desc = "[C]opy [B]uffer [N]ame"
})
