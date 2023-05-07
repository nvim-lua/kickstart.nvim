-- my keymaps
vim.keymap.set('i', 'jk', '<Esc>', { desc="Back to normal mode from insert mode" });
vim.keymap.set('i', 'kj', '<Esc>', { desc="Back to normal mode from insert mode" });
vim.keymap.set({'n', 'x'}, 'B', '0', { desc="Move to beginning of line" });
vim.keymap.set({'n', 'x'}, 'E', '$', { desc="Move to end of line" });

-- move text up or down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc="Move line down one line" });
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc="Move line up one line" });
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc="Move line down one line" });
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc="Move line up one line" });
vim.keymap.set('x', '<A-j>', ":m '>+1<CR>gv=gv", { desc="Move selection down one line" });
vim.keymap.set('x', '<A-k>', ":m '<-2<CR>gv=gv", { desc="Move selection up one line" });

-- move text across and back (indenting)
vim.keymap.set('n', '<A-l>', '>>_', { desc="Move (indent) text right" });
vim.keymap.set('n', '<A-h>', '<<_', { desc="Move (de-indent text left" });
vim.keymap.set('i', '<A-l>', '<C-t>', { desc="Move (indent) text right" });
vim.keymap.set('i', '<A-h>', '<C-d>', { desc="Move (de-indent) text left" });
vim.keymap.set('x', '<A-l>', '>gv', { desc="Move (indent) text right" });
vim.keymap.set('x', '<A-h>', '<gv', { desc="Move (de-indent) text left"});

