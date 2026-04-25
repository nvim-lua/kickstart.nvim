-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Reset colors for some elements after changing the colorscheme.',
  group = vim.api.nvim_create_augroup('ElementsColorReset', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'WinSeparator', vim.api.nvim_get_hl(0, { name = 'CursorLineNr' }))
    vim.api.nvim_set_hl(0, 'EndOfBuffer', vim.api.nvim_get_hl(0, { name = 'CursorLineNr' }))
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Rename terminal buffer',
  group = vim.api.nvim_create_augroup('RenameTerminalBufer', { clear = true }),
  callback = function(ev)
    local pid, cmd = ev.file:match '//(%d-:)(.+)'
    cmd = vim.fs.basename(cmd)
    vim.api.nvim_buf_set_name(ev.buf, 'term://' .. pid .. cmd)
  end,
})
