vim.opt.relativenumber = true
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>gs", ':Git<CR>')
vim.keymap.set("n", "<leader>gp", ':Git pull<CR>')
vim.keymap.set("n", "<leader>gpsh", ':Git push<CR>')
vim.keymap.set("n", "gh", '<cmd>diffget //2<CR>')
vim.keymap.set("n", "gl", '<cmd>diffget //3<CR>')
