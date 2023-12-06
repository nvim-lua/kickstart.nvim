return {
    'vxpm/ferris.nvim',
    opts = {
        -- your options here
        -- If true, will automatically create commands for each LSP method
	create_commands = true, -- bool
	-- Handler for URL's (used for opening documentation)
	url_handler = "xdg-open", -- string | function(string)
    }
}
