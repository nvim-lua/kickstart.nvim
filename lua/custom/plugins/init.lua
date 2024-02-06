-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Color scheme
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Zen Mode with :ZenMode
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        width = 0.80,
      },
    },
  },

  -- Automatic formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
      },
      formatters = {
        black = {
          prepend_args = { '--preview' },
        },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },

  -- Maintain context (function name/loops) at top of buffer
  'nvim-treesitter/nvim-treesitter-context',

  -- Refactor support with :Refactor
  {
    'ThePrimeagen/refactoring.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Automatic bracket pairs
  'jiangmiao/auto-pairs',

  -- Edit files/directories as a buffer
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- Searchable command reference with :CheatSheet
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
  },

  --  Automatically install tools through Mason
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'black',
        'stylua',
        'debugpy',
      },
    },
  },

  -- Add inline git history in floating windows
  'rhysd/git-messenger.vim',

  -- vim/tmux navigation
  'christoomey/vim-tmux-navigator',

  -- Tint inactive windows
  { 'miversen33/sunglasses.nvim', opts = {
    filter_type = 'SHADE',
    filter_percent = 0.35,
  } },

  -- Harpoon
  'ThePrimeagen/harpoon',
}
