return {
	--Gruvbox colorscheme
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ..., lazy = true },

	--tokyonight colorscheme
	{ "folke/tokyonight.nvim",    priority = 1000, lazy = true },

	-- lunar-vim colorschemes
	{ "lunarvim/colorschemes",    priority = 1000, lazy = true },

	-- kanagawa
	{ "rebelot/kanagawa.nvim",    priority = 1000, lazy = true },

	-- latte, frappe, macchiato, mocha
	{ "catppuccin/catppuccin",    priority = 1000, lazy = true },

	-- Theme inspired by Atom
	{ 'navarasu/onedark.nvim',    priority = 1000, config = true, lazy = true },

	--Rosepine (Primeagen)
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		priority = 1000,
		lazy = false
	}
}
