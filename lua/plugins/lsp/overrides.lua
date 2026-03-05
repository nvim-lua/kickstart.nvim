---@diagnostic disable: undefined-global
-- Override internal LSP functions to ensure position_encoding is always set

local M = {}

function M.setup()
  -- Patch the symbols_to_items function to always use utf-16 encoding
  -- and handle nil values safely
  local original_symbols_to_items = vim.lsp.util.symbols_to_items
  vim.lsp.util.symbols_to_items = function(symbols, bufnr, position_encoding)
    -- Default to utf-16 if not specified
    position_encoding = position_encoding or 'utf-16'
    
    -- Add extra safety checks for nil values
    if not symbols or type(symbols) ~= 'table' then
      return {}
    end
    
    -- Call original with proper encoding
    return original_symbols_to_items(symbols, bufnr, position_encoding)
  end
  
  -- Patch workspace_symbol handler to be safer
  vim.lsp.handlers['workspace/symbol'] = function(err, result, ctx, config)
    if err or not result or vim.tbl_isempty(result) then
      return {}
    end
    
    -- Set a default position_encoding
    local position_encoding = 'utf-16'
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client and client.offset_encoding then
      position_encoding = client.offset_encoding
    end
    
    -- Process safely
    local items = vim.lsp.util.symbols_to_items(result, nil, position_encoding) or {}
    return items
  end
  
  -- Patch all lsp_* functions in telescope.builtin to include position_encoding
  local telescope_builtin = require('telescope.builtin')
  local telescope_funcs = {
    'lsp_references', 'lsp_definitions', 'lsp_implementations',
    'lsp_type_definitions', 'lsp_document_symbols', 'lsp_workspace_symbols',
    'lsp_dynamic_workspace_symbols'
  }
  
  for _, func_name in ipairs(telescope_funcs) do
    local original_func = telescope_builtin[func_name]
    telescope_builtin[func_name] = function(opts)
      opts = opts or {}
      if not opts.position_encoding then
        opts.position_encoding = 'utf-16'
      end
      return original_func(opts)
    end
  end
end

return M
