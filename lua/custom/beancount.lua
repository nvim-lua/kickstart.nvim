local warned_missing_bean_format = false

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'beancount',
  group = vim.api.nvim_create_augroup('beancount-format-check', { clear = true }),
  callback = function()
    if warned_missing_bean_format or vim.fn.executable 'bean-format' == 1 then return end
    warned_missing_bean_format = true
    vim.notify('bean-format not found. Install it with: uv tool install beancount', vim.log.levels.WARN, { title = 'conform.nvim' })
  end,
})
