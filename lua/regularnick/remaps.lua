-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

vim.keymap.set(
  'n',
  '<C-n>',
  ':Neotree toggle current reveal_force_cwd<cr>',
  { desc = 'Open the explorer in the folder the current file is contained and changes the cwd' }
)
-- Recommended keymaps for Neo-tree??? why do they want me to remap fricking / to do some of their command it's literally a search!
-- nnoremap / :Neotree toggle current reveal_force_cwd<cr>
-- nnoremap | :Neotree reveal<cr>
-- nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
-- nnoremap <leader>b :Neotree toggle show buffers right<cr>
-- nnoremap <leader>s :Neotree float git_status<cr>

vim.keymap.set('n', '<M-/>', ':bn<cr>', { desc = 'Go to the next buffer' })
vim.keymap.set('n', '<M-,>', ':bp<cr>', { desc = 'Go to the previous buffer' })
vim.keymap.set('n', '<M-n>', ':enew<cr>', { desc = 'Go to the previous buffer' })
vim.keymap.set('n', '<M-w>', ':bd<cr>', { desc = 'Go to the previous buffer' })
