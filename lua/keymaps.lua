--  See `:help vim.keymap.set()`

-- Personnal Keymaps
-- normal mode
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')

vim.keymap.set('n', '<leader>ra', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'Replace the word under the cursor in the file' })

vim.keymap.set('n', '<leader>v', '<cmd>vsplit<CR>', { desc = 'Vertical split' })

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'Make the current buffer/file executable' })

vim.keymap.set('n', ';', ':', { desc = 'Replace : by ;' })

vim.keymap.set('n', 'Q', ':noh<CR>')

vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Moves focus to upper window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Moves focus to lower window' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Moves focus to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Moves focus to right window' })

vim.keymap.set('n', '<leader>V', ':vert terminal<CR>', { desc = 'open terminal in vertical split' })

-- insert mode
vim.keymap.set('i', '<C-h>', '<left>')
vim.keymap.set('i', '<C-j>', '<down>')
vim.keymap.set('i', '<C-k>', '<up>')
vim.keymap.set('i', '<C-l>', '<right>')

-- while in insert mode, go to the start of line
vim.keymap.set('i', '<C-b>', '<ESC>^i')

-- while in insert mode, go to end of line
vim.keymap.set('i', '<C-e>', '<End>')

-- better escape insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- visual mode

-- better escape visual mode
vim.keymap.set('v', 'sd', '<Esc>')

-- move the highlighted line(s) up and indent if needed
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'make the selected hightlighted line and go up one line, indent if possible and highlight it again' })

-- move te highlighted line(s) down and indent if needed
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'make the selected hightlighted line and go down one line, indent if possible and highlight it again' })
-- end personnal keymaps

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
