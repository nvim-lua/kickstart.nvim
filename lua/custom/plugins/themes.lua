return {

	{

		'folke/tokyonight.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'tokyonight-night'
		end,

	},

	{ -- Theme inspired by Atom
		'navarasu/onedark.nvim',
	},
	{
		"ellisonleao/gruvbox.nvim",
		-- config = function()
		-- 	vim.o.background = "light"
		-- 	vim.cmd.colorscheme 'gruvbox'
		-- end,

	}


}
