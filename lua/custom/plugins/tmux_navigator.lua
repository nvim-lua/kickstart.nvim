return {
	'christoomey/vim-tmux-navigator',
	lazy = false,
	config = function()
		vim.keymap.set("n", "<c-LEFT>", "<CMD>TmuxNavigateLeft<CR>", { desc = "tmux window left"})
		vim.keymap.set("n", "<c-RIGHT>", "<CMD>TmuxNavigateRight<CR>", { desc = "tmux window right"})
		vim.keymap.set("n", "<c-DOWN>", "<CMD>TmuxNavigateDown<CR>", { desc = "tmux window down"})
		vim.keymap.set("n", "<c-UP>", "<CMD>TmuxNavigateUp<CR>", { desc = "tmux window up"})
	end,
}
