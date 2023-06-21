return {
	"kylechui/nvim-surround",
	version = "*",   -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- vim - surround maps
		})
		vim.keymap.set("n", "<leader>`", "ysiw`")
		vim.keymap.set("n", "<leader>'", "ysiw'")
		vim.keymap.set("n", '<leader>"', 'ysiw"')
	end
}
