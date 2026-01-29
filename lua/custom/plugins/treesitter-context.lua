return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = false })
  end,
}
