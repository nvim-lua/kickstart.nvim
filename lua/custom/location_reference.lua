local M = {}

local sk = vim.lsp.protocol.SymbolKind
local symbol_kinds = {
  [sk.Class] = true,
  [sk.Method] = true,
  [sk.Constructor] = true,
  [sk.Enum] = true,
  [sk.Interface] = true,
  [sk.Function] = true,
  [sk.Struct] = true,
}

local function range_contains(range, line0, col0)
  if not range then
    return false
  end

  local start_line = range.start.line
  local start_col = range.start.character
  local end_line = range['end'].line
  local end_col = range['end'].character

  if line0 < start_line or line0 > end_line then
    return false
  end
  if line0 == start_line and col0 < start_col then
    return false
  end
  if line0 == end_line and col0 > end_col then
    return false
  end

  return true
end

local function range_size(range)
  -- Weight lines heavily so a single-line range is always smaller than a multi-line one
  return (range['end'].line - range.start.line) * 100000 + (range['end'].character - range.start.character)
end

local function append_document_symbols(symbols, out, parent_name)
  for _, symbol in ipairs(symbols or {}) do
    local symbol_name = symbol.name
    local full_name = parent_name and (parent_name .. '.' .. symbol_name) or symbol_name
    table.insert(out, {
      name = full_name,
      kind = symbol.kind,
      range = symbol.range,
    })
    append_document_symbols(symbol.children, out, full_name)
  end
end

local function append_symbol_information(symbols, out)
  for _, symbol in ipairs(symbols or {}) do
    local name = symbol.name
    if symbol.containerName and symbol.containerName ~= '' then
      name = symbol.containerName .. '.' .. name
    end
    table.insert(out, {
      name = name,
      kind = symbol.kind,
      range = symbol.location and symbol.location.range,
    })
  end
end

local function get_symbol_at_cursor()
  if #vim.lsp.get_clients { bufnr = 0 } == 0 then
    return nil
  end

  local params = { textDocument = vim.lsp.util.make_text_document_params() }
  local responses = vim.lsp.buf_request_sync(0, 'textDocument/documentSymbol', params, 500)
  if not responses then
    return nil
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local line0 = cursor[1] - 1
  -- LSP ranges use UTF-16 offsets; convert from byte offset for correct matching
  -- on files with non-ASCII characters (e.g. CJK, emoji).
  local line_text = vim.api.nvim_buf_get_lines(0, line0, line0 + 1, false)[1] or ''
  local col0 = vim.str_utfindex(line_text, 'utf-16', cursor[2])
  local symbols = {}

  for _, response in pairs(responses) do
    if not response.error then
      local result = response.result
      if type(result) == 'table' and result[1] then
        if result[1].selectionRange or result[1].children then
          append_document_symbols(result, symbols, nil)
        else
          append_symbol_information(result, symbols)
        end
      end
    end
  end

  local best_symbol, best_size
  for _, symbol in ipairs(symbols) do
    if symbol_kinds[symbol.kind] and range_contains(symbol.range, line0, col0) then
      local size = range_size(symbol.range)
      if not best_size or size < best_size then
        best_size = size
        best_symbol = symbol.name
      end
    end
  end

  return best_symbol
end

local function get_relative_path_from_root(file_path)
  local root = vim.fs.root(file_path, { '.git' }) or vim.fn.getcwd()

  if vim.fs.relpath then
    local rel = vim.fs.relpath(root, file_path)
    if rel then
      return rel
    end
  end

  local prefix = root
  if not prefix:match '/$' then
    prefix = prefix .. '/'
  end
  if file_path:sub(1, #prefix) == prefix then
    return file_path:sub(#prefix + 1)
  end

  return file_path
end

local function get_file_parts()
  local file_path = vim.api.nvim_buf_get_name(0)
  if file_path == '' then
    vim.notify('No file path for current buffer', vim.log.levels.WARN)
    return nil
  end

  return {
    file_path = file_path,
    file_rel = get_relative_path_from_root(file_path),
  }
end

local function get_location_parts()
  local parts = get_file_parts()
  if not parts then
    return nil
  end

  local mode = vim.api.nvim_get_mode().mode
  local loc

  if mode == 'v' or mode == 'V' or mode == '\22' then
    -- Use 'v' (visual anchor) and '.' (cursor) for the live selection.
    -- '</'> marks are only reliable after exiting visual mode (e.g. ':' mappings),
    -- but <Cmd> mappings stay in visual mode so those marks are stale.
    local start_pos = vim.fn.getpos 'v'
    local end_pos = vim.fn.getpos '.'
    local s_line, s_col = start_pos[2], start_pos[3]
    local e_line, e_col = end_pos[2], end_pos[3]

    -- getpos('v') returns zeros when called outside a real visual context; fall back.
    if s_line == 0 then
      local cur = vim.api.nvim_win_get_cursor(0)
      s_line, s_col = cur[1], cur[2] + 1
      e_line, e_col = s_line, s_col
    elseif s_line > e_line or (s_line == e_line and s_col > e_col) then
      s_line, e_line = e_line, s_line
      s_col, e_col = e_col, s_col
    end

    loc = string.format('%d:%d-%d:%d', s_line, s_col, e_line, e_col)
  else
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line_num = cursor[1]
    local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1] or ''
    local end_col = math.max(vim.fn.strchars(line_text), 1)
    loc = string.format('%d:%d-%d:%d', line_num, 1, line_num, end_col)
  end

  return {
    file_path = parts.file_path,
    file_rel = parts.file_rel,
    loc = loc,
    symbol = get_symbol_at_cursor(),
  }
end

local function yank(label, value)
  vim.fn.setreg('"', value)
  pcall(vim.fn.setreg, '+', value)
  vim.notify('Copied ' .. label .. ': ' .. value, vim.log.levels.INFO)
end

function M.copy_absolute_location_reference()
  local parts = get_location_parts()
  if not parts then
    return
  end

  local location = string.format('%s:%s', parts.file_path, parts.loc)
  if parts.symbol and parts.symbol ~= '' then
    location = location .. ' symbol:' .. parts.symbol
  end

  yank('absolute location', location)
end

function M.copy_relative_location_reference()
  local parts = get_location_parts()
  if not parts then
    return
  end

  local symbol = parts.symbol and parts.symbol ~= '' and parts.symbol or 'none'
  yank('relative location', string.format('@%s loc:%s symbol:%s', parts.file_rel, parts.loc, symbol))
end

function M.copy_buffer_file_reference()
  local parts = get_file_parts()
  if not parts then
    return
  end

  yank('buffer file', string.format('@%s', parts.file_rel))
end

function M.copy_buffer_directory_reference()
  local parts = get_file_parts()
  if not parts then
    return
  end

  local abs_dir = vim.fn.fnamemodify(parts.file_path, ':h')
  local rel_dir = get_relative_path_from_root(abs_dir)
  yank('buffer directory', string.format('@%s', rel_dir))
end

return M
