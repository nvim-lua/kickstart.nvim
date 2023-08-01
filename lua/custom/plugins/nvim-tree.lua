-- recommended for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
	end,
}
