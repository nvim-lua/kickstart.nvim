local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { 'css' } }),
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
	},
})

return {}
