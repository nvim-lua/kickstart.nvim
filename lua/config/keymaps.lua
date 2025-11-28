local map = vim.keymap.set
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- Clear highlights on search when pressing <C-c> in normal mode
--  See `:help hlsearch`
map('n', '<C-c>', '<cmd>nohlsearch<CR>')

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

map("n", "<leader>ot", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape to Normal mode in terminal" })

map("v", "<leader>p", '"_dP', { desc = "Replace and paste with blackhole register" })

map("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

map("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
