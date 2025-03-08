-- Plugin declarations

local plugins = {
  -- :Git/:G
  'tpope/vim-fugitive',
  -- :GBrowse on github
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically (Editor Config taken into account)
  'tpope/vim-sleuth',

  'styled-components/vim-styled-components',

  -- This is where plugins related to LSP can be installed.
  -- The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {}
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      -- 'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {}
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- JSDoc
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    version = "*",
    opts = {
      languages = {
        typescript = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
      }
    }
  },

  --[[
  {
    -- Theme inspired by Atom
    'Mofiqul/dracula.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'dracula'
    end,
  },
  --]]

  {
    'HiPhish/rainbow-delimiters.nvim',
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'onedark',
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_x = { 'fileformat', 'filetype' },
        lualine_y = {},
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
      indent = { char = "┊" },
      scope = {
        show_start = false,
        show_end = false,
      }
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {}
  },

  -- Fuzzy Finder (files, lsp, etc)
  require 'core.plugins.file-search',

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
    branch = "master"
  },

  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig",         -- optional
    },
    opts = {}                          -- your configuration
  },

  -- require plugins with more complex config

  require 'core.plugins.todo-comments',

  require 'core.plugins.project-tree',

  require 'core.plugins.nvim-ufo',

  require 'kickstart.plugins.autoformat',

  require 'core.plugins.lsp-file-operations',

  require 'core.plugins.copilot',

  require 'core.plugins.markdown-preview',
}

local pluginOptions = {}

require('lazy').setup(plugins, pluginOptions)
