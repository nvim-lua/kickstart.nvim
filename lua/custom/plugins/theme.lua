return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 900,
		config = function()
			require('catppuccin').setup({
				term_colors = true,
				styles = {
					comments = { "italic" },
					conditionals = {},
				},
				integrations = {
					treesitter = true,
				},
			})
			vim.cmd.colorscheme 'catppuccin'
		end,
	},
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
			},
			sections = { lualine_x = { 'filetype', 'tabnine' } }
		},
	}
}
