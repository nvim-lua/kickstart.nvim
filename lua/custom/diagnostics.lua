-- Custom LSP diagnostic configuration
local M = {}

M.setup = function()
  vim.diagnostic.config {
    virtual_text = {
      prefix = '●', -- Change symbol if needed
      spacing = 4,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      source = 'always',
    },
  }

  -- Show diagnostics in a floating window when hovering
  vim.o.updatetime = 250
  vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })
end

return M
