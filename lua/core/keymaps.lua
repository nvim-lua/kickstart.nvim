-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
-- vim.keymap.set('n', 'g*', '*zz')
-- vim.keymap.set('n', 'g#', '#zz')
vim.keymap.set('n', '{', '{zt')
vim.keymap.set('n', '}', '}zt')
vim.keymap.set('n', '(', '(zt')
vim.keymap.set('n', ')', ')zt')

vim.keymap.set('n', '<leader>tl', '<cmd>Lazy<CR>', { desc = '[T]oggle [L]azy' })
vim.keymap.set('n', '<leader>tm', '<cmd>Mason<CR>', { desc = '[T]oggle [M]ason' })
vim.keymap.set('n', '<leader>ta', '<cmd>set arabic!<CR>', { desc = '[T]oggle [A]rabic' })
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<CR>', { noremap = true, silent = true, desc = '[T]oggle [W]rap' })

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[w]rite buffer' })
vim.keymap.set('n', '<leader>y', '<cmd>%y<CR>', { desc = '[y]ank buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = '[q]uit buffer' })
vim.keymap.set('n', '<leader>c', '<cmd>bdelete<CR>', { desc = '[c]lose file' })

-- Add a keymap for delete while on insert-mode
-- this works well with <C-h>, <C-w>, <C-u>
vim.keymap.set('i', '<C-f>', '<Del>')

-- [[ Keymap Deletion ]]

-- this would be remapped to `grs` so I don't want to keep it.
vim.keymap.del('n', 'gO')
