return {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {
    max_lines = 4,
    multiline_threshold = 20,
    trim_scope = 'outer',
  },
  keys = {
    {
      '<leader>tc',
      function()
        require('treesitter-context').toggle()
      end,
      desc = '[T]oggle code [C]ontext',
    },
  },
}
