local lisp_dialects = { "clojure", "fennel", "scheme", "lisp" }

return {
	{
		"gpanders/nvim-parinfer",
		ft = lisp_dialects,
		init = function()
			vim.g.parinfer_force_balance = true
			vim.g.parinfer_comment_chars = ";;"
		end,
	},
	{
		"julienvincent/nvim-paredit",
		ft = { "clojure", "fennel", "scheme" },
		config = function()
			local paredit = require("nvim-paredit")
			paredit.setup({
				use_default_keys = false,
				keys = {
					["<localleader>-"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice sexp" },

					[">e"] = { paredit.api.drag_element_forwards, "Drag element right" },
					["<e"] = { paredit.api.drag_element_backwards, "Drag element left" },

					[">f"] = { paredit.api.drag_form_forwards, "Drag form right" },
					["<f"] = { paredit.api.drag_form_backwards, "Drag form left" },

					["<localleader>uf"] = { paredit.api.raise_form, "Raise form" },
					["<localleader>ue"] = { paredit.api.raise_element, "Raise element" },

					["E"] = {
						paredit.api.move_to_next_element_tail,
						"Jump to next element tail",
						-- by default all keybindings are dot repeatable
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},
					["W"] = {
						paredit.api.move_to_next_element_head,
						"Jump to next element head",
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},

					["B"] = {
						paredit.api.move_to_prev_element_head,
						"Jump to previous element head",
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},
					["gE"] = {
						paredit.api.move_to_prev_element_tail,
						"Jump to previous element tail",
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},

					["("] = {
						paredit.api.move_to_parent_form_start,
						"Jump to parent form's head",
						repeatable = false,
						mode = { "n", "x", "v" },
					},
					[")"] = {
						paredit.api.move_to_parent_form_end,
						"Jump to parent form's tail",
						repeatable = false,
						mode = { "n", "x", "v" },
					},

					-- These are text object selection keybindings which can used with standard `d, y, c`, `v`
					["af"] = {
						paredit.api.select_around_form,
						"Around form",
						repeatable = false,
						mode = { "o", "v" }
					},
					["if"] = {
						paredit.api.select_in_form,
						"In form",
						repeatable = false,
						mode = { "o", "v" }
					},
					["aF"] = {
						paredit.api.select_around_top_level_form,
						"Around top level form",
						repeatable = false,
						mode = { "o", "v" }
					},
					["iF"] = {
						paredit.api.select_in_top_level_form,
						"In top level form",
						repeatable = false,
						mode = { "o", "v" }
					},
					["ae"] = {
						paredit.api.select_element,
						"Around element",
						repeatable = false,
						mode = { "o", "v" },
					},
					["ie"] = {
						paredit.api.select_element,
						"Element",
						repeatable = false,
						mode = { "o", "v" },
					},
				}
			})
		end
	},
	{
		"julienvincent/nvim-paredit-fennel",
		dependencies = { "julienvincent/nvim-paredit" },
		ft = { "fennel" },
		config = function()
			require("nvim-paredit-fennel").setup()
		end
	},
	{
		"ekaitz-zarraga/nvim-paredit-scheme",
		dependencies = { "julienvincent/nvim-paredit" },
		ft = { "scheme" },
		config = function()
			require("nvim-paredit-scheme").setup(require("nvim-paredit"))
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

			-- Guile socket repl support
			vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
		end,
	},
	{ "udalov/javap-vim", ft = "java" },
}
