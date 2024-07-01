require("config.lazy")
require("lsp.gopls")

vim.cmd("colorscheme kanagawa")

vim.o.mouse = ""

vim.o.number = true
vim.o.relativenumber = true

vim.o.clipboard = "unnamedplus"

vim.o.cursorline = true

vim.o.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.g.have_nerd_font = false

vim.keymap.set("n", "<leader>j", "<c-w>", { silent = true })
vim.keymap.set("n", "<leader>j-", "<c-w>s", { silent = true })
vim.keymap.set("n", "<leader>j|", "<c-w>v", { silent = true })

vim.keymap.set("n", "<leader>k", "<cmd>tabnew<CR>", { silent = true })

vim.keymap.set("n", "<leader>h", "<cmd>Ex<CR>", { silent = true })

