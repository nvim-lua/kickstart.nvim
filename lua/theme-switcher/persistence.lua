local M = {}

local config_dir = vim.fn.stdpath 'data'
local theme_file = config_dir .. '/theme_preference.txt'

-- Save theme preference
function M.save_theme(theme_name)
  local file = io.open(theme_file, 'w')
  if file then
    file:write(theme_name)
    file:close()
    return true
  end
  return false
end

-- Load theme preference
function M.load_theme()
  local file = io.open(theme_file, 'r')
  if file then
    local theme = file:read '*all'
    file:close()
    return theme:match '^%s*(.-)%s*$' -- trim whitespace
  end
  return nil
end

-- Delete preference
function M.clear_theme()
  os.remove(theme_file)
end

return M
