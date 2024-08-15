return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {},
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  config = function()
    require('render-markdown').setup()
  end,
}
