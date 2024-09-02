-- https://github.com/nvim-treesitter/nvim-treesitter-context
return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {},
  config = function(_, opts)
    require('treesitter-context').setup(opts)
    vim.keymap.set('n', '<leader>tc', ':TSContextToggle<CR>', { noremap = true, silent = true, desc = '[T]oggle current [C]ontext' })
  end,
}
