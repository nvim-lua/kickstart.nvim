vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Erlubt es markierte Bloecke an code mit ctr j k zu verschieben
vim.keymap.set("v", "J", ":m '>+1<CR>gv+gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursour in the middle while page jumping
vim.keymap.set("n", "C-d", "<C-d>zz")
vim.keymap.set("n", "C-u", "<C-u>zz")

-- Keep search tearms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over marked Text, keep buffer
vim.keymap.set("x", "<leader>p", "\"_d")

-- Seperate vim and system clipboard
vim.keymap.set("n", "<leader>d", "\"_d")

-- telescope remaps
--
-- quckfixes
