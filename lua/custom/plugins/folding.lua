return {
  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt.foldenable = false
    end,
  },
}

