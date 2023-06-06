vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-s>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<Home>", "_")
vim.keymap.set("n", "<End>", "$")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set({ "i", "x" }, "kj", "<Esc>")
vim.keymap.set("i", "<C-d>", "<C-o>de")
vim.keymap.set("i", "<C-h>", "<Backspace>")
vim.keymap.set("i", "<C-l>", "<Del>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
    { desc = "LSP: format buffer" })

vim.keymap.set("n", "<leader>ru",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "[R]eplace word [U]nder cursor" })
