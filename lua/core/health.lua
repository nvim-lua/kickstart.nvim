-- Health check for the modular Neovim configuration

local M = {}

local check_version = function()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.10-dev') then
    vim.health.ok(string.format("Neovim version is: '%s'", verstr))
  else
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
  end
end

local check_external_reqs = function()
  -- Basic utils
  for _, exe in ipairs { 'git', 'make', 'unzip' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end
  
  -- Search tools
  for _, exe in ipairs { 'rg', 'fd' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found search tool: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find search tool: '%s' (required for Telescope)", exe))
    end
  end
end

local check_lsp_servers = function()
  -- Check for LSP servers installed via Nix
  local servers = {
    { name = 'clangd', desc = 'C/C++ language server' },
    { name = 'pyright', desc = 'Python language server' },
    { name = 'ruff', desc = 'Python linter/formatter' },
    { name = 'nixd', desc = 'Nix language server' },
    { name = 'texlab', desc = 'LaTeX language server' },
    { name = 'cmake-language-server', desc = 'CMake language server' },
  }
  
  vim.health.start('LSP Servers (via Nix/Home Manager)')
  for _, server in ipairs(servers) do
    local is_executable = vim.fn.executable(server.name) == 1
    if is_executable then
      vim.health.ok(string.format("Found %s: '%s'", server.desc, server.name))
    else
      vim.health.info(string.format("Not found: '%s' (%s) - install via Nix if needed", server.name, server.desc))
    end
  end
end

local check_formatters = function()
  -- Check for formatters installed via Nix
  local formatters = {
    { name = 'stylua', filetype = 'lua' },
    { name = 'clang-format', filetype = 'c/cpp' },
    { name = 'alejandra', filetype = 'nix' },
  }
  
  vim.health.start('Formatters (via Nix/Home Manager)')
  for _, formatter in ipairs(formatters) do
    local is_executable = vim.fn.executable(formatter.name) == 1
    if is_executable then
      vim.health.ok(string.format("Found formatter for %s: '%s'", formatter.filetype, formatter.name))
    else
      vim.health.info(string.format("Not found: '%s' (%s) - install via Nix if needed", formatter.name, formatter.filetype))
    end
  end
end

function M.check()
  vim.health.start('Modular Neovim Configuration')

  vim.health.info [[NOTE: Not every warning needs to be fixed.
Only install tools for languages you actually use.
All language servers and formatters should be installed via Nix/Home Manager.]]

  local uv = vim.uv or vim.loop
  vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))

  check_version()
  check_external_reqs()
  check_lsp_servers()
  check_formatters()
end

return M