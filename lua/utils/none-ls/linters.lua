local M = {}

local null_ls = require('null-ls')
local services = require('utils.none-ls.services')
local method = null_ls.methods.DIAGNOSTICS

local alternative_methods = {
  null_ls.methods.DIAGNOSTICS,
  null_ls.methods.DIAGNOSTICS_ON_OPEN,
  null_ls.methods.DIAGNOSTICS_ON_SAVE,
}

function M.list_registered(filetype)
  local registered_providers = services.list_registered_providers_names(filetype)
  local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
    return registered_providers[m] or {}
  end, alternative_methods))

  return providers_for_methods
end

function M.list_supported(filetype)
  local s = require('null-ls.sources')
  local supported_linters = s.get_supported(filetype, 'diagnostics')
  table.sort(supported_linters)
  return supported_linters
end

function M.setup(linter_configs)
  if vim.tbl_isempty(linter_configs) then
    return
  end

  local registered = services.register_sources(linter_configs, method)

  if #registered > 0 then
    vim.notify('Registered the following linters: ' .. unpack(registered), vim.log.levels.DEBUG)
  end
end

return M
