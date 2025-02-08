vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>a', { desc = 'Save file' })
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { desc = 'Quit Neovim' })
vim.keymap.set('n', '<C-S-q>', '<cmd>qa!<CR>', { desc = 'Force Quit Neovim' })

-- Use 'jk' to exit insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Use 'Y' to yank (copy) to the end of the line
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keybindings for folding
vim.keymap.set('n', 'zc', 'zc', { desc = 'Close fold' }) -- Collapse current fold
vim.keymap.set('n', 'zo', 'zo', { desc = 'Open fold' }) -- Open current fold
vim.keymap.set('n', 'za', 'za', { desc = 'Toggle fold' }) -- Toggle fold open/close
vim.keymap.set('n', 'zR', 'zR', { desc = 'Open all folds' }) -- Open all folds
vim.keymap.set('n', 'zM', 'zM', { desc = 'Close all folds' }) -- Close all folds
