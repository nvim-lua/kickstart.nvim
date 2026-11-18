local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('n', '<leader>qq', '<CMD>q!<CR>', { desc = 'Quit all without close' })
map('n', '<leader>bd', '<CMD>bd<CR>', { desc = 'Close current buffer' })
map('n', '<S-h>', '<CMD>bprev<CR>', { desc = 'Go to previous buffer' })
map('n', '<S-l>', '<CMD>bnext<CR>', { desc = 'Go to next buffer' })
map('n', '<C-s>', '<CMD>w<CR>', { desc = 'Save a file' })

map('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move lines (note: overrides the default `K` LSP hover mapping in normal mode)
map('n', 'J', '<CMD>m .+1<CR>==', { desc = 'Move line down' })
map('n', 'K', '<CMD>m .-2<CR>==', { desc = 'Move line up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- git-conflict.nvim
map('n', 'co', '<Plug>(git-conflict-ours)', { desc = 'Conflict: choose ours' })
map('n', 'ct', '<Plug>(git-conflict-theirs)', { desc = 'Conflict: choose theirs' })
map('n', 'cb', '<Plug>(git-conflict-both)', { desc = 'Conflict: choose both' })
map('n', 'c0', '<Plug>(git-conflict-none)', { desc = 'Conflict: choose none' })
map('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Previous conflict' })
map('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Next conflict' })
