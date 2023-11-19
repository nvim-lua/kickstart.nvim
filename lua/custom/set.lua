vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

vim.api.nvim_exec([[
	augroup numbertoggle
		autocmd!
		autocmd InsertEnter * set norelativenumber
		autocmd InsertLeave * set relativenumber
	augroup END
]], false)
