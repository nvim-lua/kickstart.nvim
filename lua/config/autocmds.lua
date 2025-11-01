-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 300 })
  end,
})

-- Ensure focus starts in the editor, not file tree
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Focus editor window on startup, not Neo-tree',
  group = vim.api.nvim_create_augroup('kickstart-focus-editor', { clear = true }),
  callback = function()
    -- Wait a bit for plugins to load, then focus first non-special buffer
    vim.defer_fn(function()
      -- Find the first normal buffer window
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
        local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
        -- Skip special buffers like neo-tree, terminal, etc.
        if buftype == '' and filetype ~= 'neo-tree' then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end, 50) -- 50ms delay to let plugins initialize
  end,
})

-- Ensure virtual text diagnostics are enabled after all plugins load
-- This needs to be set after plugins that might override diagnostic config
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    vim.diagnostic.config {
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '■',
        format = function(diagnostic)
          return diagnostic.message
        end,
      },
    }
  end,
})

-- Command to restart Python LSP (useful when switching projects/venvs)
vim.api.nvim_create_user_command('PythonRestart', function()
  local clients = vim.lsp.get_clients { name = 'pyright' }
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id, true)
  end
  vim.notify('Pyright stopped. It will restart on next edit.', vim.log.levels.INFO)
end, { desc = 'Restart Python LSP (pyright)' })
