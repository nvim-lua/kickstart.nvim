-- LSP Configuration Module
local M = {}

function M.setup()
  local lspconfig = require 'lspconfig'

  -- Get capabilities from blink.cmp if available
  local capabilities = {}
  pcall(function()
    capabilities = require('blink.cmp').get_lsp_capabilities()
  end)
  --
  -- Set global position encoding preference
  capabilities.offsetEncoding = { 'utf-8', 'utf-16' }

  -- Load server configurations
  local servers = require('plugins.config.lsp.servers').get_servers()

  -- Setup each server with capabilities
  for name, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
    lspconfig[name].setup(config)
  end

  -- Setup LSP keymaps
  require('plugins.config.lsp.keymaps').setup()
end

return M

