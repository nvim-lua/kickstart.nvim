return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = true,
	keys = { 
		{ '<leader>t', ":ToggleTerm size=15<cr>" },
		{ '<leader>t', mode = { "t" }, "<C-\\><C-n><CMD>ToggleTerm size=15<cr>" },
		{ '<esc>',     mode = { "t" }, [[<C-\><C-n>]] }
	}
}
