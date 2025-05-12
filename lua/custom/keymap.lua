-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode

vim.keymap.set('n', '<C-o>', '<cmd>ClangdSwitchSourceHeader<CR>', { desc = 'Swith to source/header file' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- vim.keymap.set('n', '<leader>z', require('telescope').extensions.zoxide.list, { desc = '[Z]oxide to different dir' })
-- vim.keymap.set('n', '<leader>jl', require('telescope.builtin').jumplist, { desc = '[J]ump [L]ist' })
vim.keymap.set('n', '<leader>ft', function()
  vim.g.disable_format = not vim.g.disable_autoformat
end, { desc = 'Auto[F]ormat [T]oggle ' })
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
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Tmux jump between tmux and nvim with nvim keybindings
vim.keymap.set('n', '<c-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Move to left pane in tumx' })
vim.keymap.set('n', '<c-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Move to down pane in tumx' })
vim.keymap.set('n', '<c-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Move to up pane in tumx' })
vim.keymap.set('n', '<c-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Move to right pane in tumx' })
vim.keymap.set('n', '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Move to last pane in tumx' })
