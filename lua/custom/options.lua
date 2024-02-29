vim.o.mouse = ""
vim.wo.relativenumber = true
vim.go.tabstop = 2

vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber norelativenumber" })

return {}
