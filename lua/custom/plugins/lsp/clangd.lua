local M = {}

M.clang_filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }

local lspconfig = require 'lspconfig'
local watcher

local function find_compile_commands()
  local lines = vim.fn.systemlist { 'fd', '-u', '-t', 'f', 'compile_commands.json' }

  if vim.tbl_isempty(lines) then
    return nil
  end

  table.sort(lines, function(a, b)
    return a:match 'debug' and not b:match 'debug'
  end)

  return vim.fn.fnamemodify(lines[1], ':h')
end

function M.stop_clangd()
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name == 'clangd' then
      client.stop { force = true }
      vim.notify '[clangd] stopped clangd'
    end
  end
end

function M.setup_clangd(commands_dir)
  vim.notify('[clangd] Setting up with: ' .. commands_dir)
  M.stop_clangd()

  lspconfig.clangd.setup {
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--header-insertion=never',
      '--query-driver=' .. vim.fn.exepath 'clang++',
      '--resource-dir=' .. vim.fn.systemlist({ 'clang++', '--print-resource-dir' })[1],
      '--compile-commands-dir=' .. (commands_dir or '.'),
    },
    root_dir = lspconfig.util.root_pattern '.git',
    single_file_support = true,
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  }

  -- for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  --   local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
  --   if vim.tbl_contains(M.clang_filetypes, ft) then
  --     vim.lsp.buf_attach_client(bufnr, vim.lsp.get_clients({ name = 'clangd' })[1].id)
  --   end
  -- end
end

function M.pick_commands_dir()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  pickers
    .new({}, {
      prompt_title = 'Choose compile_commands.json location',
      finder = finders.new_oneshot_job { 'fd', '-u', 'compile_commands.json', '-x', 'dirname', '{}' },
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local entry = require('telescope.actions.state').get_selected_entry()
          local commands_dir = entry[1]
          require('telescope.actions').close(prompt_bufnr)
          if commands_dir ~= '' then
            M.setup_clangd(commands_dir)
          end
        end)
        return true
      end,
    })
    :find()
end

function M.watch_compile_commands()
  if watcher then
    return
  end

  vim.notify('clangd: Starting watcher for compile_commands.json', vim.log.levels.INFO)
  local uv = vim.uv or vim.loop
  watcher = uv.new_fs_event()
  local cwd = vim.fn.getcwd()

  watcher:start(
    cwd,
    { recursive = true },
    vim.schedule_wrap(function(_, fname, status)
      if fname and fname:match 'compile_commands%.json$' and status.change then
        vim.notify('[clangd] Detected change: ' .. fname, vim.log.levels.INFO)
        watcher:stop()
        watcher = nil
        M.setup_clangd(vim.fn.fnamemodify(fname, ':h'))
      end
    end)
  )
end

return {
  'neovim/nvim-lspconfig',
  ft = M.clang_filetypes,
  config = function()
    local dir = find_compile_commands()
    if dir then
      vim.notify('[clangd] Found compile_commands at: ' .. dir)
      M.setup_clangd(dir)
    else
      vim.notify '[clangd] No compile_commands found, watching ...'
      M.watch_compile_commands()
    end

    vim.keymap.set('n', '<leader>cc', M.pick_commands_dir, { desc = 'Pick location of compile_commands.json for clangd' })
  end,
}
