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
--   { -- Leave it here in case we want to configure LSP directly
--   "neovim/nvim-lspconfig",
--   config = function()
--     -- Configure the Pyright language server for Python
--     vim.lsp.config('pyright', {
--       cmd = { "pyright-langserver", "--stdio" },
--       filetypes = { "python" },
--     })
--     -- Enable the LSP server for Python files
--     vim.lsp.enable('pyright')
--   end,
--   }

  {
    -- handle LSP server installation and management
    -- let's be lazy for now.
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },

  { -- Auto completion engine
    'saghen/blink.cmp',
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

  { -- Let lsp recognize vim functions
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
     dependencies = { 'nvim-lua/plenary.nvim' },
     config = function()
       require('telescope').setup({})
     end,
    }
}
