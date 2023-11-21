return {
	"folke/trouble.nvim",
	config = function(_, opts)
		require('trouble').setup(opts)

		-- vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
		-- 	{ silent = true, noremap = true }
		-- )
		-- vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
		-- 	{ silent = true, noremap = true }
		-- )
		-- vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
		-- 	{ silent = true, noremap = true }
		-- )
		-- vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
		-- 	{ silent = true, noremap = true }
		-- )
		-- vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
		-- 	{ silent = true, noremap = true }
		-- )
		-- vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
		-- 	{ silent = true, noremap = true }
		-- )
		vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
		vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
		vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
		vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
		vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		use_diagnostic_signs = true,
	},
}
