-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- restore cursor on the opening of a file
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('user-restore-cursor', { clear = true }),
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if not (ft:match 'commit' or ft:match 'rebase') and last_known_line > 1 and last_known_line <= vim.api.nvim_buf_line_count(opts.buf) then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})