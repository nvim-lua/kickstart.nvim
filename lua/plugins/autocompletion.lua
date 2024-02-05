return {
	-- Autocompletion
	'hrsh7th/nvim-cmp',
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',

		-- Adds LSP completion capabilities
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-path',

		-- Adds a number of user-friendly snippets
		'rafamadriz/friendly-snippets',

		-- Auto-closing brackets, quotes, etc.
		'windwp/nvim-autopairs',
	},
	config = function()
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'

		require('nvim-autopairs').setup();
		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

		require('luasnip.loaders.from_vscode').lazy_load()
		luasnip.config.setup {}

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = 'menu,menuone,noinsert',
			},
			mapping = cmp.mapping.preset.insert {
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-k>'] = cmp.mapping.select_prev_item(),
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete {},
				['<Tab>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'path' },
			},
			experimental = {
				ghost_text = true,
			}
		}
	end
}
