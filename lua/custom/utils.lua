local async = require 'plenary.async'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local sorters = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local function collect_executables(start_dir)
  local results = {}
  local fd_result = vim
    .system({
      'fd',
      '.',
      start_dir,
      '--exec',
      'file',
      '{}',
    }, { text = true })
    :wait()

  local lines = vim.split(fd_result.stdout, '\n', { trimempty = true })

  for _, line in ipairs(lines) do
    local path, typeinfo = line:match '^(.-):%s*(.+)$'
    if path and not path:match 'CMakeFiles' and typeinfo and (typeinfo:match 'Mach%-O' or typeinfo:match 'ELF') then
      table.insert(results, path)
    end
  end

  return results
end

local function pick_executable(start_dir)
  vim.notify('pick_executable() was triggered with start_dir=' .. start_dir, vim.log.levels.INFO)
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
          actions.select_default:replace(function(bufnr)
            local entry = action_state.get_selected_entry()
            actions.close(bufnr)
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
}
