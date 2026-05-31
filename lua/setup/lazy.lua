-- [[ Install lazy.nvim ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Git related plugins
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>gv', '<cmd>DiffviewOpen<CR>', desc = '[G]it Diff[V]iew' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it File [H]istory' },
    },
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Completion
  { import = 'plugins.blink' },
  { import = 'plugins.autopairs' },

  -- LSP
  { import = 'plugins.lsp' },
  { import = 'plugins.mason' },

  -- Treesitter
  { import = 'plugins.treesitter' },

  -- Formatting & Linting
  { import = 'plugins.conform' },
  { import = 'plugins.lint' },

  -- UI
  { import = 'plugins.colorscheme' },
  { import = 'plugins.lualine' },
  { import = 'plugins.snacks' },
  { import = 'plugins.noice' },
  { import = 'plugins.neo-tree' },
  { import = 'plugins.which-key' },
  { import = 'plugins.indent_line' },
  { import = 'plugins.render-markdown' },
  { import = 'plugins.highlight-colors' },
  { import = 'plugins.todo-comments' },
  { import = 'plugins.log-highlight' },

  -- Navigation
  { import = 'plugins.telescope-fuzzy-finder' },
  { import = 'plugins.smart-splits' },
  { import = 'plugins.treesj' },

  -- Git
  { import = 'plugins.fugitive' },
  { import = 'plugins.gitsigns' },

  -- Editing
  { import = 'plugins.surround' },
  -- { import = 'plugins.mini-nvim' },    -- replaced by individual mini.ai below
  { import = 'plugins.mini-ai' },

  -- Terminal
  { import = 'plugins.toggleterm' },

  -- AI
  { import = 'plugins.copilot' },
  { import = 'plugins.copilot-chat' },
  { import = 'plugins.codecompanion' },

  -- Debugging
  { import = 'plugins.debug' },

  -- Language specific
  { import = 'plugins.cmake-tools' },
  { import = 'plugins.unreal' },

  -- Misc
  { import = 'plugins.lazy-dev' },
}, {
  ui = {
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
