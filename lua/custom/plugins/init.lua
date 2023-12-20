return {
	-- File Browser
	{ 'stevearc/oil.nvim' },

	-- Rust Format on Save
	{
		'rust-lang/rust.vim',
		ft = "rust",
		init = function ()
			vim.g.rustfmt_autosave = 1
		end
	},

	-- Theme
	{ 'catppuccin/nvim', name='catppuccin', priority = 1000 },

	-- Better Comments
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua//plenary.nvim' }
	},
}

