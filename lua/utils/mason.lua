local M = {}

-- any cases where name of package is different from the binary name
local name_to_bin = {
  -- ['csharp-language-server'] = 'csharp-ls',
  -- ['python-lsp-server'] = 'pylsp',
  -- ['docker-compose-language-service'] = 'docker-compose-langserver',
}

M.missing = function(ensure_installed)
  if type(ensure_installed) == 'string' then
    ensure_installed = { ensure_installed }
  end

  local result = {}
  for lsp_name, config in pairs(ensure_installed) do
    local executable_name = lsp_name
    if config['alias'] then
      executable_name = config['alias']
    end

    -- check if executable exists
    if vim.fn.executable(executable_name) ~= 1 then
      result[lsp_name] = config
    end
  end
  return result
end

-- We guarantee 'ensure_installed' package is installed locally
-- If enforce_local is false then we install it via mason-registry
-- By default we install LSPs via mason
M.install = function(ensure_installed)
  -- ensure installed is expected of the form <lspname>: {cmd: "", settings: {...}}

  -- ensure_installed = M.missing(ensure_installed, enforce_local)
  local lspconfig_to_pkg = require('mason-lspconfig').get_mappings().lspconfig_to_package

  local registry = require 'mason-registry'
  -- local mason_lspconfig = require 'mason-lspconfig'
  registry.refresh(function()
    for lsp_cfg, _ in pairs(ensure_installed) do
      local pkg_name = lspconfig_to_pkg[lsp_cfg] -- get mason package name based on lspconfig name
      local pkg = registry.get_package(pkg_name)
      if not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

return M
