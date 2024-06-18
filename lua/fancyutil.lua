-- init module
local _M = {}

--- @param winnr integer | nil
--- @return true | false | nil
function _M.get_oil_nnn(winnr)
  winnr = winnr or 0
  local ok, value = pcall(vim.api.nvim_win_get_var, winnr, 'nnn')
  if not ok then
    return nil
  end
  if value then
    return true
  end
  return false
end

--- @param val boolean
--- @param winnr integer | nil
function _M.set_oil_nnn(val, winnr)
  winnr = winnr or 0
  vim.api.nvim_win_set_var(winnr, 'nnn', val)
end

return _M
