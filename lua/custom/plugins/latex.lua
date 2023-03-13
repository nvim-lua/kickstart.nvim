-- install texlive-most
return {
	'lervag/vimtex',
	'sirver/ultisnips',
	'KeitaNakamura/tex-conceal.vim',
	config = function()
		vim.g.UltiSnipsExpandTrigger = '<tab>'
		vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
		vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
		vim.g.tex_flavor = 'latex'
		vim.g.vimtex_view_method = 'zathura'
		vim.g.vimtex_quickfix_mode = 0
		vim.g.tex_conceal = 'abdmg',
	end
}
