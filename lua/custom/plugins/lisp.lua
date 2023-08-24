local lisp_dialects = { "clojure", "fennel", "scheme", "lisp" }

return {
	{
		"gpanders/nvim-parinfer",
		ft = { unpack(lisp_dialects) },
		init = function()
			vim.g.parinfer_force_balance = true
			vim.g.parinfer_comment_chars = ";;"
		end,
	},
	{
		"Olical/conjure",
		ft = { unpack(lisp_dialects) },
		init = function()
			vim.api.nvim_create_autocmd("BufNewFile", {
				group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
				pattern = { "conjure-log-*" },
				callback = function() vim.diagnostic.disable(0) end,
				desc = "Conjure Log disable LSP diagnostics",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("comment_config", { clear = true }),
				pattern = { "clojure" },
				callback = function() vim.bo.commentstring = ";; %s" end,
				desc = "Lisp style line comment",
			})
		end,
	},
}
