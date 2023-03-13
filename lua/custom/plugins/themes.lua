return {

	{
		'folke/tokyonight.nvim',
		priority = 1000,
		config = function()
		end,
	},

	{ -- Theme inspired by Atom
		'navarasu/onedark.nvim',
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			-- setup must be called before loading the colorscheme
			-- Default options:
			require("gruvbox").setup({
				undercurl = true,
				underline = true,
				bold = true,
				italic = true,
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					SignColumn = { bg = "#1d2021" }
				},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.o.background = "dark"
			vim.cmd.colorscheme 'gruvbox'
		end,
	},
	{
		"sainnhe/edge",
	},
	{
		"catppuccin/nvim",
		"rmehri01/onenord.nvim",
		"AlexvZyl/nordic.nvim",
		'marko-cerovac/material.nvim',
		"Shatur/neovim-ayu",
		'doums/darcula',
		"sainnhe/gruvbox-material",
		config = function()
		end
	}


}
