local M = {}
M.clang_filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }

local lspconfig = require 'lspconfig'
local uv = vim.uv or vim.loop
local watcher, debounce_timer

local function find_compile_commands()
  local results = vim.fn.systemlist { 'fd', '-u', '-t', 'f', 'compile_commands.json' }
  table.sort(results, function(a, b)
    return a:match 'debug' and not b:match 'debug'
  end)
  return results[1] and vim.fn.fnamemodify(results[1], ':h') or nil
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

  if dir then
    vim.notify('[clangd] Setting up with: ' .. dir)
    table.insert(cmd, '--compile-commands-dir=' .. dir)
  else
    vim.notify '[clangd] No compile_commands.json found.\nUse <leader>lc to manually set location.'
  end

  lspconfig.clangd.setup {
    cmd = cmd,
    filetypes = M.clang_filetypes,
    root_dir = lspconfig.util.root_pattern '.git',
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    single_file_support = true,
    on_attach = function(client, bufnr)
      vim.notify('[clangd] Attached to buffer ' .. bufnr)
    end,
  }

  if dir then
    M.watch_compile_commands(dir)
  end
end

function M.watch_compile_commands(dir)
  if watcher then
    watcher:stop()
    watcher:close()
  end
  if debounce_timer then
    debounce_timer:stop()
    debounce_timer:close()
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

      if fname and fname:match '[/\\]compile_commands%.json$' and status.change then
        debounce_timer = uv.new_timer()
        debounce_timer:start(200, 0, function()
          vim.schedule(function()
            vim.notify '[clangd] Detected compile_commands.json change. Reloading ...'
            local new_dir = vim.fn.fnamemodify(fname, ':h')
            M.start_clangd(new_dir)
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
          if entry then
            vim.defer_fn(function()
              M.start_clangd(entry[1])
            end, 100)
          end
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
    vim.api.nvim_create_autocmd('BufReadPost', {
      group = vim.api.nvim_create_augroup('clangd-once', { clear = true }),
      pattern = '*',
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if vim.tbl_contains(M.clang_filetypes, ft) then
          vim.notify('[clangd] BufReadPost fired for ft=' .. ft)
          local dir = find_compile_commands()
          M.start_clangd(dir)
          vim.api.nvim_clear_autocmds { group = 'clangd-once' }
        end
      end,
    })

    vim.keymap.set('n', '<leader>lc', M.pick_commands_dir, {
      desc = '[L]ocate [c]ompile_commands.json for clangd',
    })
  end,
}
