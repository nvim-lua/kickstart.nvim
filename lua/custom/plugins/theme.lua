return {
	'chriskempson/base16-vim',
	priority = 1000,
	config = function()
		vim.cmd.colorscheme 'base16-bright'
	end,
}
