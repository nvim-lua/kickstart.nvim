return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function()
    require('kanagawa').setup { theme = 'dragon', transparent = false }
    vim.o.termguicolors = true
    -- vim.cmd 'colorscheme kanagawa-dragon'
  end,
}
