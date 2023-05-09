local function format_item(entry, vim_item)
  -- Add the source name to the beginning of the label
  vim_item.menu = '[' .. entry.source.name .. '] '
  if entry.source.get_debug_name then
    -- If the source is an LSP, add the LSP name to the menu and kind fields
    vim_item.menu = '[' .. entry.source:get_debug_name() .. ']'
    -- vim_item.kind = string.format('%s %s', entry.source.name, vim_item.kind)
  else
    -- If the source is not an LSP, use a default value for the menu and kind fields
    vim_item.menu = vim_item.menu
    -- vim_item.kind = string.format('%s %s', entry.source.name, vim_item.kind)
  end
  return vim_item
end

-- Configure nvim-cmp
-- local cmp = require 'cmp'
-- local config = cmp.get_config()
-- table.insert(config.formatting, {
--   format = format_item,
-- })
-- cmp.setup(config)

require('cmp').setup {
  formatting = {
    format = format_item,
  },
}

return {}
