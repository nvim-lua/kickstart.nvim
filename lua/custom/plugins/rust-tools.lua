return {
	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-lua/plenary.nvim',
			'mfussenegger/nvim-dap',
		},
		opts = function(_, _)
			require("rust-tools").setup({})
		end,
	},
}
