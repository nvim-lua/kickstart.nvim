local M = {}
M.clang_filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }
M.auto_watch_enabled = true

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
      pcall(function()
        client.stop { force = true }
      end)
      vim.notify '[clangd] Stopped clangd'
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
    vim.notify('[clangd] Setting up with: ' .. dir)
    table.insert(cmd, '--compile-commands-dir=' .. dir)
  else
    vim.notify '[clangd] No compile_commands.json found.\nUse <leader>cc to manually set location'
    table.insert(cmd, '--compile-commands-dir=.')
  end

  lspconfig.clangd.setup {
    cmd = cmd,
    filetypes = M.clang_filetypes,
    root_dir = lspconfig.util.root_pattern '.git',
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    single_file_support = true,
  }
end

local watcher, debounce_timer

function M.watch_compile_commands(dir)
  local uv = vim.uv or vim.loop

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

  local watch_path = dir or vim.fn.getcwd()
  local watch_file = watch_path .. '/compile_commands.json'

  if not M.auto_watch_enabled or not vim.fn.filereadable(watch_file) then
    return
  end

  watcher = uv.new_fs_event()
  watcher:start(
    watch_path,
    { recursive = true },
    vim.schedule_wrap(function(err, fname, status)
      if err then
        vim.notify('[clangd] Watcher error: ' .. err, vim.log.levels.ERROR)
        return
      end

      if fname and fname:match '.*/compile_commands%.json$' and status.change then
        debounce_timer = uv.new_timer()
        debounce_timer:start(200, 0, function()
          vim.schedule(function()
            vim.notify '[clangd] Detected compile_commands.json change. Reloading ...'
            watch_path = vim.fn.fnamemodify(fname, ':h')
            M.start_clangd(watch_path)
            M.watch_compile_commands(watch_path)
          end)
        end)
      end
    end)
  )
end

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
          vim.defer_fn(function()
            M.reload_clangd(entry[1])
          end, 100)
        end)
        return true
      end,
    })
    :find()
end

return {
  'neovim/nvim-lspconfig',
  ft = M.clang_filetypes,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('clangd-lazy-init', { clear = true }),
      pattern = table.concat(M.clang_filetypes, ','),
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if vim.tbl_contains(M.clang_filetypes, ft) then
          local dir = find_compile_commands()
          M.start_clangd(dir)
          if dir ~= '' then
            M.watch_compile_commands(dir)
          else
            M.watch_compile_commands()
          end

          vim.keymap.set('n', '<leader>cc', M.pick_commands_dir, { desc = 'Pick location of compile_commands.json for clangd', buffer = args.buf })
          vim.api.nvim_clear_autocmds { group = 'clangd-lazy-init' }
        end
      end,
    })
  end,
}
