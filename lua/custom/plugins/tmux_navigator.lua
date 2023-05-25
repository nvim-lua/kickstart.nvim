return {
	'christoomey/vim-tmux-navigator',
	lazy = false,
	config = function()
		vim.keymap.set("n", "<c-h>", "<CMD>TmuxNavigateLeft<CR>", { desc = "tmux window left"})
		vim.keymap.set("n", "<c-l>", "<CMD>TmuxNavigateRight<CR>", { desc = "tmux window right"})
		vim.keymap.set("n", "<c-j>", "<CMD>TmuxNavigateDown<CR>", { desc = "tmux window down"})
		vim.keymap.set("n", "<c-k>", "<CMD>TmuxNavigateUp<CR>", { desc = "tmux window up"})
	end,
}
