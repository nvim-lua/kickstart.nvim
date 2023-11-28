local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  {
    'nvim-treesitter',
    dependencies = {
      'nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    'kylechui/nvim-surround',
    opts = { config = {} }
  }
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'go', 'python', 'rust', 'javascript', 'typescript' },
  auto_install = true,
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      scope_incremental = '<TAB>',
      node_decremental = '<BS>',
    }
  }
})
