-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Dracula theme
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'dracula'
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

  -- Buffer tabs at top
  {
    'akinsho/bufferline.nvim',
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
      },
    },
  },

  -- Add inline git history in floating windows
  'rhysd/git-messenger.vim',
}
