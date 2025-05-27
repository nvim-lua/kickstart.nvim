local async = require 'plenary.async'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local sorters = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local function collect_executables(start_dir)
  local results = {}

  -- Add '.', start_dir so it works with your fd version
  local fd = vim.fn.systemlist {
    'fd',
    '.',
    start_dir,
    '--exec',
    'file',
    '{}',
  }

  for _, line in ipairs(fd) do
    local path, typeinfo = line:match '^(.-):%s*(.+)$'
    if path and not path:match 'CMakeFiles' and typeinfo and (typeinfo:match 'Mach%-O' or typeinfo:match 'ELF') then
      table.insert(results, path)
    end
  end

  return results
end

local function pick_executable(start_dir)
  return async.wrap(function(_start_dir, on_choice)
    local executables = collect_executables(_start_dir)

    if #executables == 0 then
      vim.notify('No executables found in ' .. _start_dir, vim.log.levels.WARN)
      on_choice(nil)
      return
    end

    pickers
      .new({}, {
        prompt_title = 'Select Executable',
        finder = finders.new_table { results = executables },
        sorter = sorters.generic_sorter {},
        attach_mappings = function(_, map)
          actions.select_default:replace(function(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            on_choice(entry.value)
          end)
          map('i', '<Esc>', function(bufnr)
            actions.close(bufnr)
            on_choice(nil)
          end)
          map('n', 'q', function(bufnr)
            actions.close(bufnr)
            on_choice(nil)
          end)
          return true
        end,
      })
      :find()
  end, 2)(start_dir)
end

return {
  pick_executable = pick_executable,

  clangd_base_cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
    '--query-driver=' .. vim.fn.trim(vim.fn.system 'which clang++'),
    '--resource-dir=' .. vim.fn.trim(vim.fn.system 'clang++ --print-resource-dir'),
  },
  make_clangd_cmd = function(self, compile_commands_dir)
    local cmd = vim.deepcopy(self.clangd_base_cmd)
    table.insert(cmd, '--compile-commands-dir=' .. compile_commands_dir)
    return cmd
  end,

  find_targets = function()
    return vim.fn.systemlist 'fd -u compile_commands.json -x dirname {}'
  end,

  get_target = function(self)
    return vim.g.current_target_dir or 'build/debug'
  end,

  set_target = function(self, dir)
    vim.g.current_target_dir = dir
    print(' set_target:', dir)
    self:reload_clangd()
  end,

  pick_target = function(self)
    local targets = self.find_targets()
    if vim.tbl_isempty(targets) then
      vim.notify('No build targets found.', vim.log.WARN)
      return
    end
    vim.ui.select(targets, { prompt = 'Select build target:' }, function(choice)
      if choice then
        self:set_target(choice)
      end
    end)
  end,

  reload_clangd = function(self)
    local lspconfig = require 'lspconfig'
    local configs = require("lspconfig.configs")

    local cmd = self:make_clangd_cmd(self:get_target())
    print(' clangd cmd:', vim.inspect(cmd))

    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.name == 'clangd' then
        print(' stopping old clangd')
        client.stop()
      end
    end

  if not configs.clangd then
    configs.clangd = {
    default_config = {
    cmd = cmd,
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", '.git'),
    single_file_support = true,
    },
  }
else
  configs.clangd.default_config.cmd = cmd
end

  lspconfig.clangd.setup({ cmd = cmd })

local buf = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)
  loal ft = vim.bo[buf].filetype

 if name ~= "" and ft:match('c') then
    print(" reopening buffer to auto-attach clangd")
    vim.cmd("edit")
else
  print(" Skipping buffer reload: name or filetype invalid")
  end
end,

list_attached_clients = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    print("No LSP clients attached to this buffer.")
    return
  end
  for _, client in ipairs(clients) do
    print("LSP:", client.name, "id:", client.id)
  end
end,

list_attached_clients = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    print("No LSP clients attached to this buffer.")
    return
  end
  for _, client in ipairs(clients) do
    print("LSP:", client.name, "id:", client.id)
  end
end,
}
