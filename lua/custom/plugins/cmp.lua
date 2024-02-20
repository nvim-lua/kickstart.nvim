return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"onsails/lspkind-nvim",
		{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		lspkind.init({
			mode = "symbol_text",
			preset = "codicons",
		})

		cmp.setup({
			formatting = {
				format = function(entry, item)
					item.kind = lspkind.presets.default[item.kind]
					item.menu = ({
						nvim_lsp = "[LSP]",
						nvim_lua = "[Lua]",
						buffer = "[Buffer]",
						path = "[Path]",
						calc = "[Calc]",
						look = "[Dict]",
					})[entry.source.name]
					return require("tailwindcss-colorizer-cmp").formatter(entry, item)
				end,
			},
		})
	end,
	experimental = {
		-- I like the new menu better! Nice work hrsh7th
		native_menu = false,

		-- Let's play with this for a day or two
		ghost_text = false,
	},
}
