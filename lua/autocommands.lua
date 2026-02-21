-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Definitions

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Resize splits if window got resized
local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

Autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

-- Remove auto comment next line
Autocmd({ 'BufEnter' }, {
  group = augroup 'remove_auto_comment',
  callback = function()
    vim.cmd 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
  end,
})

-- Set cursorline only in focused window
Autocmd({ 'WinEnter', 'WinLeave' }, {
  group = augroup 'cursorline',
  callback = function()
    vim.wo.cursorline = vim.fn.win_getid() == vim.fn.win_getid()
  end,
})
