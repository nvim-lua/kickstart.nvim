local lspconfig = require 'lspconfig'
local servers = { 'pyright', 'lua_ls' }

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end
