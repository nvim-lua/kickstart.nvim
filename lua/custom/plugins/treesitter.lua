return {
  'nvim-treesitter/nvim-treesitter',
  version = '*',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'lua', 'markdown', 'cmake' },
      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
      },
    }
  end,
}
