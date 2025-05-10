return {
	{
	    'lervag/vimtex',
	    -- lazy = false,
	    init = function()
	      -- VimTeX configuration goes here, e.g.
	      vim.g.vimtex_view_general_viewer = 'okular'
	      vim.g.vimtex_compiler_method = 'latexmk'
	    end,
	}
}
