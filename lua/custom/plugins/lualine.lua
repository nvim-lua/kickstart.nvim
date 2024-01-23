return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = false,
			theme = 'onenord',
			component_separators = '|',
			section_separators = '',
		},
		sections = {
			lualine_c = {
				{
					'filename', path = 4
				}
			}
		}
	},
}
