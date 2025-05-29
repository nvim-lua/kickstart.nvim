local M = {}
M.clang_filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }

local lspconfig = require 'lspconfig'

local function find_compile_commands()
  local results = vim.fn.systemlist { 'fd', '-u', '-t', 'f', 'compile_commands.json' }
  table.sort(results, function(a, b)
    return a:match 'debug' and not b:match 'debug'
  end)
  return vim.fn.fnamemodify(results[1] or '', ':h')
end

function M.stop_clangd()
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name == 'clangd' then
      client.stop { force = true }
      vim.notify '[clangd] stopped clangd'
    end
  end
end

function M.start_clangd(dir)
  M.stop_clangd()

  local cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
    '--query-driver=' .. vim.fn.exepath 'clang++',
    '--resource-dir=' .. vim.fn.systemlist({ 'clang++', '--print-resource-dir' })[1],
  }
  if dir and dir ~= '' then
    table.insert(cmd, '--compile-commands-dir=' .. dir)
    vim.notify('[clangd] Setting up with: ' .. dir)
  else
    table.insert(cmd, '--compile-commands-dir=.')
    vim.notify '[clangd] No compile_commands.json found.\nUse <leader>cc to manually set location'
  end

  lspconfig.clangd.setup {
    cmd = cmd,
    filetypes = M.clang_filetypes,
    root_dir = lspconfig.util.root_pattern '.git',
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    single_file_support = true,
  }
end

function M.reload_clangd()
  M.stop_clangd()

  vim.defer_fn(function()
    M.start_clangd(find_compile_commands())
  end, 100)
end

--     for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--       local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
--       if vim.tbl_contains(M.clang_filetypes, ft) then
--         local client = vim.lsp.get_clients({ name = 'clangd' })[1]
--         if client then
--           vim.lsp.buf_attach_client(bufnr, client.id)
--         end
--       end
--     end
--   end, 100)
-- end

function M.pick_commands_dir()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  pickers
    .new({}, {
      prompt_title = 'Pick compile_commands.json dir',
      finder = finders.new_oneshot_job { 'fd', '-u', 'compile_commands.json', '-x', 'dirname', '{}' },
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local entry = require('telescope.actions.state').get_selected_entry()
          require('telescope.actions').close(prompt_bufnr)
          M.stop_clangd()
          vim.defer_fn(function()
            M.start_clangd(entry[1])
          end, 100)
        end)
        return true
      end,
    })
    :find()
end

-- function M.watch_compile_commands()
--   vim.notify('clangd: Starting watcher for compile_commands.json', vim.log.levels.INFO)
--   local uv = vim.uv or vim.loop
--   local check_interval = 1000 -- ms
--
--   local function try_attach()
--     local dir = find_compile_commands()
--     if dir then
--       vim.notify('[clangd] Found compile_commands at: ' .. dir)
--       M.setup_clangd(dir)
--       return true
--     end
--     return false
--   end
--
--   local timer = uv.new_timer()
--   timer:start(0, check_interval, function()
--     if try_attach() then
--       timer:stop()
--       timer:close()
--     end
--   end)
--
--   local fs_watcher = uv.new_fs_event()
--   fs_watcher:start(vim.fn.getcwd(), { recursive = true }, function(_, fname, status)
--     if fname and fname:match 'compile_commands%.json$' and status.change then
--       fs_watcher:stop()
--       vim.schedule(function()
--         vim.notify '[clangd] Detected compile_commands.json change, reloading ...'
--         M.setup_clangd(vim.fn.fnamemodify(fname, ':h'))
--       end)
--     end
--   end)
-- end

return {
  'neovim/nvim-lspconfig',
  ft = M.clang_filetypes,
  config = function()
    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = M.clang_filetypes,
    --   group = vim.api.nvim_create_augroup('clangd-setup', { clear = true }),
    --   callback = function()
    --     if not vim.lsp.get_clients({ name = 'clangd' })[1] then
    --       local dir = find_compile_commands()
    --       if dir then
    --         vim.notify('[clangd] Starting with compile_commands from: ' .. dir)
    --         M.start_clangd(dir)
    --       else
    --         vim.notify '[clangd] No compile_commands found. Using fallback config.\nUse <leader>cc to manually set location.'
    --         M.start_clangd(nil)
    --       end
    --     end
    --   end,
    -- })
    M.start_clangd(find_compile_commands())

    vim.keymap.set('n', '<leader>cc', M.pick_commands_dir, { desc = 'Pick location of compile_commands.json for clangd' })
  end,
}
