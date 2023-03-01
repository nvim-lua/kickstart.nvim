return {
	'kdheepak/lazygit.nvim',
	vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true })
}
