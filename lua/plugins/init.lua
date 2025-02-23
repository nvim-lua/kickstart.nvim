local plugins = {}

local plugin_files = vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/plugins', '*.lua', false, true)

for _, file in ipairs(plugin_files) do
  local plugin_name = file:match('.*/(.*)%.lua$')
  if plugin_name ~= 'init' then
    table.insert(plugins, require('plugins.' .. plugin_name))
  end
end

return plugins
