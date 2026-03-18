-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua
  require 'kickstart/plugins/git',
  require 'kickstart/plugins/which-key',
  -- require 'kickstart/plugins/telescope',
  require 'kickstart/plugins/fzf-lua',
  require 'kickstart/plugins/lspconfig',
  require 'kickstart/plugins/conform',
  require 'kickstart/plugins/blink-cmp',
  require 'kickstart/plugins/todo-comments',
  require 'kickstart/plugins/mini',
  require 'kickstart/plugins/treesitter',
  require 'kickstart/plugins/undotree',
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  require 'custom/plugins/snacks',
  require 'custom/plugins/oil',
  require 'custom/plugins/trouble',
  require 'custom/plugins/flash',
  -- require 'custom/plugins/harpoon',
  require 'custom/plugins/lualine',
  require 'custom/plugins/noice',
  require 'custom/plugins/theme',
  require 'custom/plugins/indent-blankline',
  -- require 'custom/plugins/leetcode',
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
