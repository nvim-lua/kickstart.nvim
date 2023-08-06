-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	'tpope/vim-surround',
	'szw/vim-maximizer',
	'vim-scripts/ReplaceWithRegister',
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	'jose-elias-alvarez/null-ls.nvim',
	"jayp0521/mason-null-ls.nvim",
}
