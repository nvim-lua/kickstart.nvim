-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local keymap = vim.keymap
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap ESC key in different modes
keymap.set("i", "jk", "<ESC>")
keymap.set("v", "jk", "<ESC>")
keymap.set("c", "jk", "<ESC>")

-- clear highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete character but don't copy into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "C-x")

-- split window
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

-- tabs
keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

--maximize window toggle
keymap.set("n", "<leader>max", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")
