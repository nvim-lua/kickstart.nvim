vim.g.neoformat_try_node_exe = 1

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.json", "*.jsonc", "*.js", "*.ts", "*.tsx", "*.jsx" },
	command = "silent Neoformat prettier",
})

return {
	"sbdchd/neoformat",
}
