return {
	"stevearc/conform.nvim",
	lazy = true,
	-- event = { "BufReadPre", "BufNewFile" }, -- to disable comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				css = { { --[[ "prettierd", ]] "prettier" } },
				graphql = { { --[[ "prettierd", ]] "prettier" } },
				html = { { --[[ "prettierd", ]] "prettier" } },
				javascript = { { --[[ "prettierd", ]] "prettier" } },
				javascriptreact = { { --[[ "prettierd", ]] "prettier" } },
				json = { { --[[ "prettierd", ]] "prettier" } },
				less = { { --[[ "prettierd", ]] "prettier" } },
				markdown = { { --[[ "prettierd", ]] "prettier" } },
				scss = { { --[[ "prettierd", ]] "prettier" } },
				svelte = { { --[[ "prettierd", ]] "prettier" } },
				typescript = { { --[[ "prettierd", ]] "prettier" } },
				typescriptreact = { { --[[ "prettierd", ]] "prettier" } },
				yaml = { { --[[ "prettierd", ]] "prettier" } },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500
			}
		})
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end
}
