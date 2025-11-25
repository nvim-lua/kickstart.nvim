local M = {}

-- Store window and buffer IDs
local win_id = nil
local buf_id = nil
local input_ns = nil

-- Create floating window with search input
function M.create_window(themes, current_theme)
  -- Calculate window size
  local width = 60
  local height = math.min(#themes + 4, 20) -- +4 for header and input

  -- Calculate position (center of screen)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create buffer
  buf_id = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf_id, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf_id, 'filetype', 'theme-switcher')
  vim.api.nvim_buf_set_option(buf_id, 'modifiable', false)

  -- Window options
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' Theme Switcher ',
    title_pos = 'center',
  }

  -- Create window
  win_id = vim.api.nvim_open_win(buf_id, true, opts)

  -- Window-local options
  vim.api.nvim_win_set_option(win_id, 'cursorline', true)
  vim.api.nvim_win_set_option(win_id, 'number', false)
  vim.api.nvim_win_set_option(win_id, 'relativenumber', false)

  input_ns = vim.api.nvim_create_namespace 'theme-switcher-input'

  M.update_display(themes, current_theme, '')

  return buf_id, win_id
end

-- Update the display with filtered themes
function M.update_display(themes, current_theme, query)
  if not buf_id or not vim.api.nvim_buf_is_valid(buf_id) then
    return
  end

  vim.api.nvim_buf_set_option(buf_id, 'modifiable', true)

  local lines = {}

  -- Input line
  table.insert(lines, '> ' .. query)
  table.insert(lines, string.rep('─', vim.api.nvim_win_get_width(win_id) - 2))

  -- Theme list
  local current_line = 3
  for i, theme in ipairs(themes) do
    local prefix = theme == current_theme and '● ' or '  '
    table.insert(lines, prefix .. theme)

    if theme == current_theme and query == '' then
      current_line = i + 2
    end
  end

  -- Handle empty results
  if #themes == 0 then
    table.insert(lines, '  No matches found')
  end

  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf_id, 'modifiable', false)

  -- Set cursor to first theme (after separator)
  if #themes > 0 then
    vim.api.nvim_win_set_cursor(win_id, { query == '' and current_line or 3, 0 })
  else
    vim.api.nvim_win_set_cursor(win_id, { 3, 0 })
  end
end

-- Close window
function M.close_window()
  if win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(win_id, true)
  end
  win_id = nil
  buf_id = nil
  input_ns = nil
end

-- Get selected theme from cursor position
function M.get_selected_theme(themes)
  if not win_id then
    return nil
  end

  local cursor = vim.api.nvim_win_get_cursor(win_id)
  local line_num = cursor[1]

  -- Subtract 2 for input line and separator
  local theme_idx = line_num - 2

  if theme_idx >= 1 and theme_idx <= #themes then
    return themes[theme_idx]
  end

  return nil
end

return M
