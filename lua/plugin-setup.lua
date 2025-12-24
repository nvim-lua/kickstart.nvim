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
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'nvim-neotest/nvim-nio', -- A library for asynchronous IO in Neovim

  require 'newbim/plugins/color-schema',
  require 'newbim/plugins/which-key',
  require 'newbim/plugins/telescope',
  require 'newbim/plugins/harpoon',
  require 'newbim/plugins/autocomplete',
  require 'newbim/plugins/lsp',
  require 'newbim/plugins/treesitter',
  require 'newbim/plugins/debug',
  require 'newbim/plugins/undotree',
  require 'newbim/plugins/todo-comments',
  require 'newbim/plugins/formatter',
  require 'newbim/plugins/git',
  require 'newbim/plugins/gitsigns',
  require 'newbim/plugins/mini',
  require 'newbim/plugins/comment',
  require 'newbim/plugins/markdown',
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

-- vim: ts=2 sts=2 sw=2 et
