-- Informational line at bottom of screen
return {
	-- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
		 options = {
			icons_enabled = false,
			theme = 'onedark',
			component_separators = '|',
			section_separators = '',
		}
	}
}
