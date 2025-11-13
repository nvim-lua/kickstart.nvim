local map = vim.keymap.set
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- Clear highlights on search when pressing <C-c> in normal mode
--  See `:help hlsearch`
map('n', '<C-c>', '<cmd>nohlsearch<CR>')
map('n', '<leader>z', function()
  print("hey")
end, { desc = "Print hey" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- open Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } )
-- Change current dir
map("n", "<leader>cc", "<cmd>cd %:p:h<CR>", { desc = "Change current dir to a current buffer" })
