---@diagnostic disable: undefined-global
-- Override internal LSP functions to ensure position_encoding is always set

local M = {}

function M.setup()
  -- Create a wrapper that ensures position_encoding is added to all calls
  local function with_encoding(fn)
    return function(params, ...)
      params = params or {}
      if not params.position_encoding then
        params.position_encoding = 'utf-16'
      end
      return fn(params, ...)
    end
  end

  -- Override standard LSP buffer functions that may be missing position_encoding
  vim.lsp.buf.code_action = with_encoding(vim.lsp.buf.code_action)
  vim.lsp.buf.rename = with_encoding(vim.lsp.buf.rename)
  vim.lsp.buf.hover = with_encoding(vim.lsp.buf.hover)
  vim.lsp.buf.formatting = with_encoding(vim.lsp.buf.formatting)
  vim.lsp.buf.range_formatting = with_encoding(vim.lsp.buf.range_formatting)
  vim.lsp.buf.format = with_encoding(vim.lsp.buf.format)
  
  -- Patch util functions as well
  local orig_make_position_params = vim.lsp.util.make_position_params
  vim.lsp.util.make_position_params = function(window, client, position_encoding)
    if not position_encoding then 
      position_encoding = 'utf-16'
    end
    return orig_make_position_params(window, client, position_encoding)
  end
  
  -- Override symbols_to_items to ensure position_encoding is set
  local orig_symbols_to_items = vim.lsp.util.symbols_to_items
  vim.lsp.util.symbols_to_items = function(symbols, bufnr, position_encoding)
    if not position_encoding then
      position_encoding = 'utf-16'
    end
    return orig_symbols_to_items(symbols, bufnr, position_encoding)
  end
end

return M
