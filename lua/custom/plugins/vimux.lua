return {
	'preservim/vimux',
	dependencies = {
		'vim-test/vim-test',
	},
	config = function()
		local opts = { noremap = true, silent = true }
		local keymap = vim.api.nvim_set_keymap
		keymap('n', '<leader>rb', '<cmd>wall <bar> TestFile<cr>', opts)
		keymap('n', '<leader>rf', '<cmd>wall <bar> TestNearest<cr>',opts)
		keymap('n', '<leader>rl', '<cmd>wall <bar> TestLast<cr>', opts)
		vim.cmd [[ let test#strategy = "vimux" ]]
	end,
}
