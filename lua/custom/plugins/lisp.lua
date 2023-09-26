local lisp_dialects = { "clojure", "fennel", "scheme", "lisp" }

return {
	-- perhaps replace parinfer with guns/vim-sexp and tpope/vim-sexp-mappings-for-regular-people
	-- {
	-- 	"gpanders/nvim-parinfer",
	-- 	ft = lisp_dialects,
	-- 	init = function()
	-- 		vim.g.parinfer_force_balance = true
	-- 		vim.g.parinfer_comment_chars = ";;"
	-- 	end,
	-- },
	{
		"julienvincent/nvim-paredit",
		ft = lisp_dialects,
		config = function()
			require("nvim-paredit").setup()
		end
	},
	{
		"Olical/conjure",
		ft = lisp_dialects,
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

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
				group = vim.api.nvim_create_augroup("repl_is_clojrue_file", { clear = true }),
				pattern = { "*.repl" },
				callback = function()
					vim.cmd([[ set ft=clojure ]])
				end,
				desc = "Associate *.repl file as a clojure filetype."
			})
		end,
	},
}
