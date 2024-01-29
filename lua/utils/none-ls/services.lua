local M = {}

function M.list_registered_providers_names(filetype)
  local s = require('null-ls.sources')
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.register_sources(configs, method)
  local null_ls = require('null-ls')
  local is_registered = require('null-ls.sources').is_registered

  local sources, registered_names = {}, {}

  for _, config in ipairs(configs) do
    local cmd = config.exe or config.command
    local name = config.name or cmd:gsub('-', '_')
    local type = method == null_ls.methods.CODE_ACTION and 'code_actions' or null_ls.methods[method]:lower()
    local source = type and null_ls.builtins[type][name]
    vim.notify(string.format('Received request to register [%s] as a %s source', name, type), vim.log.levels.DEBUG)
    if not source then
      vim.notify('Not a valid source: ' .. name, vim.log.levels.ERROR)
    elseif is_registered({ name = source.name or name, method = method }) then
      vim.notify(string.format('Skipping registering [%s] more than once', name), vim.log.levels.TRACE)
    else
      local command = M.find_command(source._opts.command) or source._opts.command

      -- treat `args` as `extra_args` for backwards compatibility. Can otherwise use `generator_opts.args`
      local compat_opts = vim.deepcopy(config)
      if config.args then
        compat_opts.extra_args = config.args or config.extra_args
        compat_opts.args = nil
      end

      local opts = vim.tbl_deep_extend('keep', { command = command }, compat_opts)
      vim.notify('Registering source ' .. name, vim.log.levels.DEBUG)
      vim.notify(vim.inspect(opts), vim.log.levels.TRACE)
      table.insert(sources, source.with(opts))
      vim.list_extend(registered_names, { source.name })
    end
  end

  if #sources > 0 then
    null_ls.register({ sources = sources })
  end
  return registered_names
end

return M
