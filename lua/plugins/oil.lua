-- file browser
return {
	'stevearc/oil.nvim',
	config = function()
		require('oil').setup()
		vim.keymap.set('n', '<leader>-', '<CMD>Oil --float<CR>', { desc = 'Open current directory' })
	end
};
