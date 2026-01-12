M = {}

M.setup = function()
  local function winbar_indent()
    local indent = 0

    -- line numbers
    if vim.wo.number or vim.wo.relativenumber then
      local numberwidth = vim.wo.numberwidth
      if numberwidth == 0 then
        -- auto width: digits in max line number
        local max_lnum = vim.api.nvim_buf_line_count(0)
        indent = indent + tostring(max_lnum):len()
      else
        indent = indent + numberwidth
      end
    end

    -- space between number + text
    indent = indent + 2

    -- signcolumn
    if vim.wo.signcolumn ~= 'no' then
      indent = indent + 1
    end

    return string.rep(' ', indent)
  end

  local function winbar_icon(filepath)
    if filepath == 'Filesystem' then
      return '  '
    elseif filepath == 'Git' then
      return '  '
    elseif filepath == 'Nvim' then
      return '  '
    end
    return '  '
  end

  -- file path
  local filepath = vim.fn.expand('%:~:.')
  -- override neo-tree default buffer name
  if filepath == 'neo-tree filesystem [1]' then
      filepath = 'Filesystem'
  -- override fugitive default buffer name
  elseif filepath:match('^fugitive://') then
    filepath = 'Git'
  elseif filepath == '' then
    filepath = 'Nvim'
  end

  local navic = require('nvim-navic')
  local location = navic.is_available() and navic.get_location() or ''

  local indent = winbar_indent()
  local icon = winbar_icon(filepath)

  if location ~= '' then
    return indent .. icon .. filepath .. ' > ' .. location
  end

  return indent .. icon .. filepath
end

return M
