-- Auto-format on save
vim.cmd([[
  augroup FormatOnSave
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
  augroup END
]])

-- Augroup for Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * lua vim.highlight.on_yank()
  augroup END
]])

-- Remove trailing whitespace
vim.cmd([[
  augroup RemoveTrailingWhitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
  augroup END
]])

-- Append newline at EOF, excluding YAML files
vim.cmd([[
  augroup append_newline_at_eof
    autocmd!
    autocmd BufWritePre * silent! if !empty(getline('$')) && getline('$') !~# '\n$' && &filetype != 'yaml' | call append(line('$'), '') | endif
  augroup END
]])

local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup('autoupdate'),
  callback = function()
    if require('lazy.status').has_updates() then
      require('lazy').update({ show = false })
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyCheck',
  -- pattern = "LazyVimStarted",
  desc = 'Update lazy.nvim plugins',
  callback = function(event)
    local start_time = os.clock()
    require('lazy').sync({ wait = false, show = false })
    local end_time = os.clock()
    print('Lazy plugins synced in ' .. (end_time - start_time) * 1000 .. 'ms')
    print(vim.print(event))
  end,
})

-- Automatically start insert mode in terminal buffers
vim.cmd([[
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * normal! G
  autocmd TermOpen * tnoremap <Esc> <C-\><C-n>
]])
