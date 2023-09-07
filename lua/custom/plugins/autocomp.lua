return {
	-- Autocompletion
	'hrsh7th/nvim-cmp',
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',

		-- Adds LSP completion capabilities
		'hrsh7th/cmp-nvim-lsp',

		-- Adds Conjure cmp
		'PaterJason/cmp-conjure',

		-- Adds a number of user-friendly snippets
		'rafamadriz/friendly-snippets',
	},
}
