return {
	'vxpm/ferris.nvim',
	opts = {
		-- your options here
		-- if true, will automatically create commands for each lsp method
		create_commands = true, -- bool
		-- handler for url's (used for opening documentation)
		url_handler = "xdg-open", -- string | function(string)
	}
}
