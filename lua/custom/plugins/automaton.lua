return {
	"Dax89/automaton.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"mfussenegger/nvim-dap", -- Debug support for 'launch' configurations (Optional)
		"hrsh7th/nvim-cmp", -- Autocompletion for automaton workspace files (Optional)
		"L3MON4D3/LuaSnip", -- Snippet support for automaton workspace files (Optional)
	},
	config = function()
		require("automaton").setup({
			debug = false,
			saveall = true,
			ignore_ft = {},

			terminal = {
				position = "botright",
				size = 10,
			},

			integrations = {
				luasnip = false,
				cmp = false,
				cmdcolor = require("automaton.utils").colors.yellow,
			},

			icons = {
				buffer = "",
				close = "",
				launch = "",
				task = "",
				workspace = "",
			},

			events = {
				workspacechanged = function(ws)
					-- "ws" is the current workspace object (can be nil)
				end
			}

		})
	end
}
