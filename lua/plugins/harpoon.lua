return {
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = true,
	keys = {
		{ "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
		{ "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
		{ "<C-j>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Navigate to first file in Harpoon" },
		{ "<C-k>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Navigate to second file in Harpoon" },
		{ "<C-l>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Navigate to third file in Harpoon" },
		{ "<C-;>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Navigate to fourth file in Harpoon" },
	},
}

