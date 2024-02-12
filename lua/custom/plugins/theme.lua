return {
	{
		'bradcush/nvim-base16',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'base16-gruvbox-dark-hard'
		end,
	},
}
