return {
	-- Theme inspired by Atom
	'navarasu/onedark.nvim',
	priority = 1000,
	config = function()
		vim.cmd.colorscheme 'onedark'
	end,
	require('onedark').setup {
		style = 'darker',
		toggle_style_key = '<leader>ts', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
		toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
	}
}
