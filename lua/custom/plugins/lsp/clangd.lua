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

function M.reload_clangd()
  M.stop_clangd()

  vim.defer_fn(function()
    M.start_clangd(find_compile_commands())
  end, 100)
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

function M.watch_compile_commands(dir)
  local uv = vim.uv or vim.loop
  local watcher = uv.new_fs_event()
  local debounce_timer

  local watch_path = dir or vim.fn.getcwd()
  local watch_file = watch_path .. '/compile_commands.json'

  if not vim.fn.filereadable(watch_file) then
    return
  end

  watcher:start(watch_path, { recursive = true }, function(err, fname, status)
    print('[clangd] Watcher triggered: ', fname, vim.inspect(status))
    if err then
      vim.schedule(function()
        vim.notify('[clangd] Watcher error: ' .. err, vim.log.levels.ERROR)
      end)
      return
    end
    if fname and fname:match 'compile_commands%.json$' and status.change then
      if debounce_timer then
        debounce_timer.stop()
        debounce_timer.close()
      end
      debounce_timer = uv.new_timer()
      debounce_timer:start(200, 0, function()
        vim.schedule(function()
          vim.notify '[clangd] Detected compile_commands.json change. Reloading ...'
          watcher:stop()
          M.start_clangd(vim.fn.fnamemodify(fname, ':h')
        end)
      end)
    end
  end)

  vim.notify('[clangd] Watching: ' .. watch_file)
end

return {
  'neovim/nvim-lspconfig',
  ft = M.clang_filetypes,
  config = function()
    vim.api.nvim_create_autocmd('BufReadPost', {
      group = vim.api.nvim_create_augroup('clangd-lazy-init', { clear = true }),
      pattern = '*',
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if vim.tbl_contains(M.clang_filetypes, ft) then
          local dir = find_compile_commands()
          M.start_clangd(dir)
          if dir ~= '' then
            M.watch_compile_commands(dir)
          end

          vim.keymap.set('n', '<leader>cc', M.pick_commands_dir, { desc = 'Pick location of compile_commands.json for clangd' })
          vim.api.nvim_clear_autocmds { group = 'clangd-lazy-init' }
        end
      end,
    })
  end,
}
