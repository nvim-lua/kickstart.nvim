-- init module
local _M = {}

--- @param bufnr integer | nil
--- @return true | false | nil
function _M.get_oil_nnn(bufnr)
  bufnr = bufnr or 0
  local ok, value = pcall(vim.api.nvim_buf_get_var, bufnr, 'nnn')
  if not ok then
    return nil
  end
  if value then
    return true
  end
  return false
end
vim.fn.get_oil_nnn = _M.get_oil_nnn

return _M
