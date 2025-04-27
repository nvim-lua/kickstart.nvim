---@diagnostic disable: undefined-global
local M = {}

function M.setup()
  -- Highlight when yanking (copying) text
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- Auto format Go files on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })

  -- Auto format Zig files on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.zig',
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

return M
