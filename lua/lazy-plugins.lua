require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  require 'kickstart.plugins.comment',

  require 'kickstart.plugins.gitsigns',

  require 'kickstart.plugins.telescope',

  require 'kickstart.plugins.otter',

  require 'kickstart.plugins.lspconfig',

  require 'kickstart.plugins.conform',

  require 'kickstart.plugins.cmp',

  require 'kickstart.plugins.kanagawa',

  require 'kickstart.plugins.todo-comments',

  require 'kickstart.plugins.mini',

  require 'kickstart.plugins.treesitter',

  require 'kickstart.plugins.vim-markdown',

  require 'kickstart.plugins.lint',

  'junegunn/goyo.vim',

  require 'kickstart.plugins.vim-pencil',

  'christoomey/vim-tmux-navigator',

  require 'kickstart.plugins.lazygit',

  require 'kickstart.plugins.image-paste',

  require 'kickstart.plugins.oil',

  require 'kickstart.plugins.quarto',

  require 'kickstart.plugins.jupytext',

  require 'kickstart.plugins.vim-slime',

  require 'kickstart.plugins.copilot',

  require 'kickstart.plugins.copilot-chat',

  require 'kickstart.plugins.octo',

  require 'kickstart.plugins.web-dev-icons',
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
