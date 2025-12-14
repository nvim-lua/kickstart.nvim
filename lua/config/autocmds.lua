-- Autocommands configuration
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Refresh files if changed outside of Neovim
vim.fn.timer_start(2000, function()
  vim.cmd 'silent! checktime'
end, { ['repeat'] = -1 })
