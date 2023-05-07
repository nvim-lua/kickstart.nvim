return {
  'dag/vim-fish',
  ft = 'fish',
  config = function()
    vim.bo.filetype = 'fish'
    vim.cmd 'compiler fish'
    vim.bo.textwidth = 79
    -- vim.bo.foldmethod = 'expr'
    -- vim.bo.foldexpr = 'nvim_treesitter#foldexpr()'
    -- vim.cmd 'setlocal foldlevelstart=1'
  end,
}
