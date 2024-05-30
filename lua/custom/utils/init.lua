local M = {}

function M.notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, opts)
  end)
end

function M.get_icon(kind, padding, no_fallback)
  if not vim.g.have_nerd_font and no_fallback then
    return ''
  end
  local icon_pack = vim.g.have_nerd_font and 'icons' or 'text_icons'
  if not M[icon_pack] then
    M.icons = require 'custom.icons.nerd_font'
    M.text_icons = require 'custom.icons.text'
  end
  local icon = M[icon_pack] and M[icon_pack][kind]
  return icon and icon .. string.rep(' ', padding or 0) or ''
end

return M
