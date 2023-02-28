-- plugin which aim to provide better tabbing experience

return {
	"abecodes/tabout.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp",
	},
	config = true,
}
