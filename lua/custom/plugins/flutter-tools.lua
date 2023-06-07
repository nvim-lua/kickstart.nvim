-- FLUTTER TOOLS
return {
	'akinsho/flutter-tools.nvim',
	lazy = false,

	dependencies = {
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim', -- optional for vim.ui.select
	},

	config = function()
		require("flutter-tools").setup {
			dev_log = {
				enabled = true,
				notify_errors = true, -- if there is an error whilst running then notify the user
				open_cmd = "tabedit", -- command to use to open the log buffer
			},

			lsp = {
				on_attach = require('custom.utils'),
			}
		} -- use default
		require("telescope").load_extension("flutter")
	end,
}
