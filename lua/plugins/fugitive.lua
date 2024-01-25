return { 'tpope/vim-fugitive',
	config = function()
		vim.keymap.set('n', '<leader>gs', '<CMD>Git<CR>', { desc = '[G]it [S]tatus' });
		vim.keymap.set('n', '<leader>ga', '<CMD>Git add -A<CR>', { desc = 'Stage [A]ll [G]it files' });
		vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = '[C]ommit staged [G]it files' });
	end
};
