local keymap = vim.keymap.set

return {

  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "kanagawa-wave"
    end,
  },

	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		main = 'nvim-treesitter.configs', -- Sets main module to use for opts
		opts = {
			ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'python' },
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true
			},
			indent = { enable = true, disable = { 'ruby' } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = 'gnn',
					node_incremental = 'grn',
					scope_incremental = 'grc',
					node_decremental = 'grm',
				},
			},
		},
	},


  { -- Auto completion engine
    'saghen/blink.cmp',
    event = 'VimEnter', -- Loads the plugin when nvim finishes starting up.
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = { preset = 'super-tab' },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
      },
    opts_extend = { "sources.default" },
  },


	{
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()
    end,
  },

  {
    "stevearc/oil.nvim",
    event = 'VimEnter', -- Loads the plugin when nvim finishes starting up.
    lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function ()
			require("oil").setup({})
		end
  },
}
