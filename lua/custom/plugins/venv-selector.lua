return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
	config = true,
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {{
		"<leader>vs", "<cmd>:VenvSelect<cr>",
		-- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
		"<leader>vc", "<cmd>:VenvSelectCached<cr>"
	}}
}

