local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting
local conditional = function(fn)
	local utils = require("null-ls.utils").make_conditional_utils()
	return fn(utils)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.prettier,
		formatting.stylua,

		-- Here we set a conditional to call the rubocop formatter. If we have a Gemfile in the project, we call "bundle exec rubocop", if not we only call "rubocop".
		conditional(function(utils)
			return utils.root_has_file("Gemfile")
					and null_ls.builtins.formatting.rubocop.with({
						command = "bundle",
						args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
					})
				or null_ls.builtins.formatting.rubocop
		end),

		-- Same as above, but with diagnostics.rubocop to make sure we use the proper rubocop version for the project
		conditional(function(utils)
			return utils.root_has_file("Gemfile")
					and null_ls.builtins.diagnostics.rubocop.with({
						command = "bundle",
						args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
					})
				or null_ls.builtins.diagnostics.rubocop
		end),
	},
	-- format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 10000 })
				end,
			})
		end
	end,
})
