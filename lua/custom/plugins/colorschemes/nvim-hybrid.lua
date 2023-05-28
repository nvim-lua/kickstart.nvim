return {
  'PHSix/nvim-hybrid',
  config = function()
    require('hybrid').setup()
    -- or use
    -- vim.cmd [[colorscheme nvim-hybrid]]
  end,
}
