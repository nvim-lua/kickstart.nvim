-- ~/dlond/nvim/lua/custom/plugins/lsp.lua
-- LSP configuration, assuming LSP servers are installed via Nix/Home Manager

local lspconfig = require 'lspconfig'
local capabilities = require('blink.cmp').get_lsp_capabilities()

local servers = {
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'basic',
        },
      },
      positionEncoding = 'utf-8',
    },
  },
  nixd = {},
  ruff = {},
  texlab = {},
  cmake = {
    cmd = { 'cmake-language-server' },
    filetypes = { 'cmake' },
    root_dir = require('lspconfig.util').root_pattern('CMakeLists.txt', '.git'),
  },
}

for server_name, server in pairs(servers) do
  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  lspconfig[server_name].setup(server)
end

return {}
