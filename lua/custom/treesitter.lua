local extra_parsers = { 'bicep', 'beancount' }

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    local ok, treesitter = pcall(require, 'nvim-treesitter')
    if not ok then return end
    treesitter.install(extra_parsers)
  end,
})
