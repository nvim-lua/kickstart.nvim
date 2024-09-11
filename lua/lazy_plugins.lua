-- NOTE: Here is where you install your plugins.
require('lazy').setup({

  require 'kickstart.plugins.which_key',
  require 'kickstart.plugins.conform',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.luvit',
  require 'kickstart.plugins.lazydev',
  require 'kickstart.plugins.fugitive',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.lspconfig',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.coloscheme',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.vim_sleuth',
  require 'kickstart.plugins.autocompletion',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.harpoon',
  require 'kickstart.plugins.todo_comments',
  require 'kickstart.plugins.comments',
  require 'kickstart.plugins.trouble',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
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
