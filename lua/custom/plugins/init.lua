-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fn.stdpath 'config' .. '/lua/custom/plugins'
for _, file in ipairs(vim.fn.readdir(plugins_dir)) do
  if file:match '%.lua$' and file ~= 'init.lua' then
    local module = file:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end
