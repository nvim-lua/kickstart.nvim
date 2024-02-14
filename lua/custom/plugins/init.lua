-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
	{
		"tpope/vim-repeat",
		version = "*",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require('neo-tree').setup {}
		end
	},
	{
		"ggandor/leap.nvim",
		version = "*",
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			require('leap').create_default_mappings()
		end
	}
}
