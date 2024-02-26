-- UI for git commands
return { 'tpope/vim-fugitive',
	config = function()
		vim.keymap.set('n', '<leader>gs', '<CMD>Git<CR>', { desc = '[G]it [S]tatus' });
		vim.keymap.set('n', '<leader>ga', '<CMD>Git add -A<CR>', { desc = 'Stage [A]ll [G]it files' });
		vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = '[C]ommit staged [G]it files' });
		vim.keymap.set('n', '<leader>gg', '<CMD>Git log --graph --oneline --decorate=short<CR>', { desc = '[G]it log [G]raph' });
		vim.keymap.set('n', '<leader>gb', '<CDM>Git blame<CR>', { desc =  '[G]it [B]lame' });
	end
};
