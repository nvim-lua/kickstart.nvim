-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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

-- [[ JMB Begin ]]

-- Save all buffer
vim.keymap.set('n', '<leader>wa', ':wall<CR>', { noremap = true, desc = '[W]rite [A]ll' })
vim.keymap.set('n', '<leader>wf', ':w<CR>', { noremap = true, desc = '[W]rite [F]ile' })

-- Create command do save with qw
vim.api.nvim_command 'cmap qw wq'
vim.api.nvim_command 'cmap WQ wq'
vim.api.nvim_command 'cmap QW wq'

-- Navigate buffers
vim.keymap.set('n', '<S-h>', ':bp<CR>', { noremap = true, desc = '[G]oto [P]revious Buffer' })
vim.keymap.set('n', '<S-l>', ':bn<CR>', { noremap = true, desc = '[G]oto [N]ext Buffer' })

-- terraform configuration
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ti', ':!make init<CR>', opts)
vim.keymap.set('n', '<leader>tv', ':!make validate<CR>', opts)
vim.keymap.set('n', '<leader>tp', ':!make plan<CR>', opts)
vim.keymap.set('n', '<leader>taa', ':!make applyA<CR>', opts)

-- [[ JMB End ]]

-- Better copy-paste between vim and system clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true, desc = 'Copy to system clipboard' })
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard' })
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true, desc = 'Paste from system clipboard in insert mode' })
