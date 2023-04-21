return {
	{
		'folke/tokyonight.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'tokyonight'
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
				inverse = false, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {

				},
				overrides = {
					SignColumn = { bg = "#1d2021" },
					LspDiagnosticsSignError = { fg = "#cc241d" },
					LspDiagnosticsSignWarning = { fg = "#d79921" },
					LspDiagnosticsSignInformation = { fg = "#458588" },
					LspDiagnosticsSignHint = { fg = "#b16286" },
					TSAnnotation = { fg = "#A12568" },
					javaAnnotation = { fg = "#A12568" },
				},
				dim_inactive = false,
				transparent_mode = false,
			})

			-- vim.cmd [[highlight Search guifg=#292e42 guibg=#bb9af7]]
			-- vim.o.background = "dark"
			-- vim.cmd.colorscheme 'gruvbox'
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
		"Everblush/everblush.vim",
		config = function()
		end
	}


}
