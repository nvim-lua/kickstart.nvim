return {
  'jose-elias-alvarez/null-ls.nvim',
  ft = { 'go', 'python' },
  opts = function()
    return require 'custom.configs.null-ls'
  end,
}
