-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Themes
  require 'themes/catppuccin',

  -- Big Config Plugins
  require 'plugins/snacks',
  require 'plugins/which-key',
  require 'plugins/telescope',

  -- LSP Plugins
  require 'plugins/lazydev',
  { 'Bilal2453/luvit-meta', lazy = true }, -- I don't remember what this does and I am too scared to remove it
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').turnOn()
    end,
  },
  require 'plugins/lspconfig', -- Main LSP Configuration
  require 'plugins/conform', -- Autoformat
  require 'plugins/treesitter',
  -- TODO: Eventually replace with blink.cmp
  require 'plugins/nvim-cmp', -- Autocompletion
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- General Plugins
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'sitiom/nvim-numbertoggle',
  require 'plugins/gitsigns', -- Adds git related signs to the gutter, as well as utilities for managing changes
  require 'plugins/mini',
  require 'plugins/oil', -- Edit files like a vim buffer
  require 'plugins/vimtex', -- Latex file editing
  -- TODO: properly configure nvim dap
  require 'kickstart.plugins.debug', -- Neovim debug adapter

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
