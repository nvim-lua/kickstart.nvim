local M = {}

local uv = vim.uv or vim.loop
local lspconfig_util = require 'lspconfig.util'

local debounce_timer, watcher

local function find_compile_commands()
  local results = vim.fn.systemlist { 'fd', '-u', '-t', 'f', 'compile_commands.json' }
  table.sort(results, function(a, b)
    return a:match 'debug' and not b:match 'debug'
  end)
  local path = results[1]
  return path and vim.fn.fnamemodify(path, ':h') or nil
end

local function start_watcher(dir, reload_callback)
  if watcher then
    watcher:stop()
    watcher:close()
    watcher = nil
  end
  if debounce_timer then
    debounce_timer:stop()
    debounce_timer:close()
    debounce_timer = nil
  end

  if not dir then
    return
  end
  watcher = uv.new_fs_event()
  watcher:start(
    dir,
    { recursive = true },
    vim.schedule_wrap(function(err, fname, status)
      if err then
        vim.notify('[clangd] Watcher error: ' .. err, vim.log.levels.ERROR)
        return
      end
      if fname and fname:match '[\\/].*compile_commands%.json$' and status.change then
        if debounce_timer then
          debounce_timer:stop()
          debounce_timer:close()
        end
        debounce_timer = uv.new_timer()
        debounce_timer:start(200, 0, function()
          vim.schedule(function()
            vim.notify '[clangd] Detected compile_commands.json change. Restarting clangd...'
            reload_callback()
          end)
        end)
      end
    end)
  )
end

M.get_server_config = function()
  local dir = find_compile_commands()
  local cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
    '--query-driver=' .. vim.fn.exepath 'clang++',
    '--resource-dir=' .. vim.fn.systemlist({ 'clang++', '--print-resource-dir' })[1],
  }

  if dir then
    table.insert(cmd, '--compile-commands-dir=' .. dir)
  else
    vim.notify '[clangd] Could not find compile_commands.json. clangd may still work in single-file mode.'
  end

  return {
    cmd = cmd,
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    root_dir = lspconfig_util.root_pattern '.git',
    single_file_support = true,
    on_attach = function(client, bufnr)
      vim.notify('[clangd] Attached to buffer ' .. bufnr)
      if dir then
        start_watcher(dir, function()
          client.stop()
          vim.defer_fn(function()
            vim.cmd 'edit' -- reloads current buffer to re-trigger LSP attach
          end, 100)
        end)
      end
    end,
  }
end

vim.api.nvim_create_user_command('ReloadClangd', function()
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == 'clangd' then
      client.stop { force = true }
    end
  end

  vim.defer_fn(function()
    vim.cmd 'edit'
  end, 100)

  vim.notify '[clangd] Restarted manually via :ReloadClangd'
end, { desc = 'manually reload clangd with updated compile_commands.json' })

return M
