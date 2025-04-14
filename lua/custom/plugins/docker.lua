return {
	"jamestthompson3/nvim-remote-containers",
	-- set statusline+=%#Container#%{g:currentContainer}
	
	init = function()
		vim.cmd [[set statusline+=%#Container#%{g:currentContainer}]]
	end
}
