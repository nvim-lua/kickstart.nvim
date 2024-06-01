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

vim.keymap.set('v', 'J', "m: '>+1<cr>gv=gv")
vim.keymap.set('v', 'K', "m: '<-2<cr>gv=gv")

vim.keymap.set('n', 'Y', 'yg$')
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
