local M = {}

-- any cases where name of package is different from the binary name
local name_to_bin = {
  -- ['csharp-language-server'] = 'csharp-ls',
  -- ['python-lsp-server'] = 'pylsp',
  -- ['docker-compose-language-service'] = 'docker-compose-langserver',
}

-- We guarantee 'ensure_installed' package is installed locally
-- If enforce_local is false then we install it via mason-registry
-- By default we install LSPs via mason
M.install = function(ensure_installed, enforce_local)
  -- Allow for passing in a single string
  if type(ensure_installed) == 'string' then
    ensure_installed = { ensure_installed }
  end

  enforce_local = enforce_local == nil and false or enforce_local

  -- Function to check if the executable exists in the PATH
  local function executable_exists(name)
    if name_to_bin[name] then
      return vim.fn.executable(name_to_bin[name]) == 1
    end
    return vim.fn.executable(name) == 1
  end

  local registry = require 'mason-registry'
  registry.refresh(function()
    for _, pkg_name in ipairs(ensure_installed) do
      if (not executable_exists(pkg_name)) and not enforce_local then
        local pkg = registry.get_package(pkg_name)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end
  end)
end

return M
