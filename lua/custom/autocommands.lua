-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_user_command('FormatDisable', function()
  vim.g.disable_autoformat = true
end, {
  desc = 'Disable autoformat-on-save',
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
