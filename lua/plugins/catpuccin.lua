return { 'catppuccin/nvim', name='catppuccin', priority = 1000,
	config = function()
		require('catppuccin').setup({
			flavour = "macchiato",
			no_italic = false,
			styles = {
				comments = { 'italic' },
				conditionals = { 'italic' },
			},
			integrations = {
				treesitter = true,
			}
		})
		vim.cmd.colorscheme 'catppuccin'
	end
};
