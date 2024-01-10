return {
	-- Extend onedark config
	-- prevent override conflict
	--
	require('onedark').setup {
		style = 'deep',
		toggle_style_key = '<leader>ts', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
		toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
	}
}
