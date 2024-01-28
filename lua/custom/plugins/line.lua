return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = true,
			theme = '16color',
			component_separators = '|',
			section_separators = '',
		},
	},
}
