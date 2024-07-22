local opts = {
  git = { log = { '--since=3 days ago' } },
  ui = { custom_keys = { false } },
  colors = { themes = { 'monokai' } },
  checker = {
    enabled = true,
    -- notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  change_detection = {
    notify = false,
  },
}

require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    import = 'custom.plugins',
    exclude = 'custom.plugins.mason',
  },
}, opts)

