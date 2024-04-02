return {
  'RRethy/base16-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- load the colorscheme here
    vim.cmd [[colorscheme base16-onedark]]
  end,
}
