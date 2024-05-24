-- @return true | false | nil
function get_oil_nnn(winnr)
  local ok, value = pcall(vim.api.nvim_win_get_var, winnr, 'nnn')
  if not ok then
    return nil
  end
  if value then
    return true
  end
  return false
end
