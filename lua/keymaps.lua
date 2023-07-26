local map = vim.keymap.set

-- Navigating splits
map({"n", "i", "v"}, "<c-k>", ":wincmd k<CR>", {desc = "Select upper split"})
map({"n", "i", "v"}, "<c-j>", ":wincmd j<CR>", {desc = "Select lower split"})
map({"n", "i", "v"}, "<c-h>", ":wincmd h<CR>", {desc = "Select left split"})
map({"n", "i", "v"}, "<c-l>", ":wincmd l<CR>", {desc = "Select right split"})
