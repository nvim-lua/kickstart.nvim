-- This fixes JS formatting
-- since the autoformat plugin provided by the kickstart
-- does not support tsserver (see kickstart.plugins.autoformat)
-- this is ment to provide safe formatting using prettier.
-- 
-- This could also be extended to support other languages
-- but at the moment it serves a a fix for JS (tsserver) formatting

return {
	'jose-elias-alvarez/null-ls.nvim',
	config = function()
		local null_ls = require("null-ls")
		local formatter = null_ls.builtins.formatting

		null_ls.setup({
			sources = {
				formatter.prettier,
				-- null_ls.builtins.diagnostics.eslint,
				-- null_ls.builtins.completion.spell,
			},
		})
	end
}
