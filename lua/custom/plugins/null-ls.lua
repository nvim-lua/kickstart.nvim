null_ls = require("null-ls")

return {

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.black,
		},
	}),

	require("mason-null-ls").setup({
		ensure_installed = { "black" }
	}),
}
