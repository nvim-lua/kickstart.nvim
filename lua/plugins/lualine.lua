-- Informational status line at bottom of screen
return {
	'nvim-lualine/lualine.nvim',
	opts = {
		options = {
			theme = 'catppuccin',
			component_separators = '|',
			section_separators = '',
		},
		sections = {
			lualine_c = {
				{ "filename", path = 1 }
			}
		}
	}
}
