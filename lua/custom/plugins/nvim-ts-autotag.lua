return {
	"windwp/nvim-ts-autotag",
	ft = {
		"javascript",
		"typescript",
		"html",
		"svelte",
	},

	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
