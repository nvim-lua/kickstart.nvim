local function get_editor(sys)
  local editor
  if sys == "Darwin" then
    editor = "skim"
  elseif sys == "Linux" then
    editor = "zathura"
  else -- windows?
    editor = "zathura"
  end
  return editor
end

return {
  "lervag/vimtex",
  config = function()
    vim.g.vimtex_view_method = get_editor(vim.loop.os_uname().sysname)
  end
}
