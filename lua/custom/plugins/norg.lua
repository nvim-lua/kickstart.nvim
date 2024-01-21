return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup {
			load = {
				["core.export"] = {},
				["core.export.markdown"] = {
					config = {
						extension = "md",
					},
				},
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
			},
		}

		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,
}
