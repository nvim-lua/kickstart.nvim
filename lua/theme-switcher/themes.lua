local M = {}

-- Automatically detect installed colorschemes
function M.get_available_themes()
  local themes = {}

  -- Get all available colorschemes from runtime paths
  local colorscheme_files = vim.api.nvim_get_runtime_file('colors/*.vim', true)
  local lua_colorschemes = vim.api.nvim_get_runtime_file('colors/*.lua', true)

  -- Combine both vim and lua colorschemes
  vim.list_extend(colorscheme_files, lua_colorschemes)

  for _, file in ipairs(colorscheme_files) do
    local name = vim.fn.fnamemodify(file, ':t:r')
    table.insert(themes, name)
  end

  -- Remove duplicates and sort
  local seen = {}
  local unique = {}
  for _, theme in ipairs(themes) do
    if not seen[theme] then
      seen[theme] = true
      table.insert(unique, theme)
    end
  end

  table.sort(unique)
  return unique
end

-- Get current colorscheme
function M.get_current_theme()
  return vim.g.colors_name or 'default'
end

-- Apply a theme
function M.apply_theme(theme_name)
  local ok, err = pcall(vim.cmd.colorscheme, theme_name)
  if not ok then
    vim.notify('Failed to load theme: ' .. theme_name, vim.log.levels.ERROR)
    return false
  end
  return true
end

return M
