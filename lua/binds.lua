--    __            __   _         __
--   / /_____ __ __/ /  (_)__  ___/ /__
--  /  '_/ -_) // / _ \/ / _ \/ _  (_-<
-- /_/\_\\__/\_, /_.__/_/_//_/\_,_/___/
--          /___/

--  See `:help vim.keymap.set()`

local global = vim.g
local o = vim.opt

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h instead"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l instead"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k instead"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j instead"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Key mapping to delete the current line using the black hole register
vim.keymap.set('n', '<C-x>', '"_dd:echo "Line deleted"<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-x>', '<Esc>"_dd:echo "Line deleted"<CR>i', { noremap = true, silent = true })
