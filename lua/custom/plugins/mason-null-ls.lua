return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
	config = function()
		require("custom.config.mason-null-ls-config")
	end,
}
