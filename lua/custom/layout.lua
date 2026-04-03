local M = {}

local sidebar_filetypes = {
  ['neo-tree'] = true,
  ['snacks_layout_box'] = true,
  ['snacks_terminal'] = true,
  ['toggleterm'] = true,
  ['opencode'] = true,
}

function M.focus_main_window()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    local bt = vim.bo[buf].buftype
    if not sidebar_filetypes[ft] and bt == '' then
      vim.api.nvim_set_current_win(win)
      return true
    end
  end

  return false
end

local function find_window_by_filetype(filetype)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == filetype then return win end
  end

  return nil
end

local function ensure_neotree_window()
  local neotree_win = find_window_by_filetype 'neo-tree'
  if neotree_win then return neotree_win end

  pcall(
    function()
      require('neo-tree.command').execute {
        action = 'show',
        source = 'filesystem',
        position = 'left',
        reveal = true,
      }
    end
  )

  return find_window_by_filetype 'neo-tree'
end

local function ensure_opencode_window()
  local opencode_win = find_window_by_filetype 'opencode'
  if opencode_win then return opencode_win end

  pcall(function() require('opencode').toggle() end)

  vim.wait(1000, function() return find_window_by_filetype 'opencode' ~= nil end, 50)
  return find_window_by_filetype 'opencode'
end

function M.reset_ide_layout()
  local neotree_win = ensure_neotree_window()
  local opencode_win = ensure_opencode_window()

  local total_columns = vim.o.columns
  local left_width = math.max(20, math.floor(total_columns * 0.10))
  local right_width = math.max(40, math.floor(total_columns * 0.25))
  local min_main_width = 40

  if left_width + right_width + min_main_width > total_columns then
    local available_sidebar_width = math.max(total_columns - min_main_width, 0)
    left_width = math.floor(available_sidebar_width * (10 / 35))
    right_width = available_sidebar_width - left_width
  end

  if neotree_win and vim.api.nvim_win_is_valid(neotree_win) then vim.api.nvim_win_set_width(neotree_win, left_width) end
  if opencode_win and vim.api.nvim_win_is_valid(opencode_win) then vim.api.nvim_win_set_width(opencode_win, right_width) end

  M.focus_main_window()
end

return M
