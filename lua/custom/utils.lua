local async = require 'plenary.async.util'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local sorters = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local Path = require 'plenary.path'

local function collect_executables(start_dir)
  local results = {}
  local fd = vim.fn.systemlist { 'fd', '--type', 'x', '--exec', 'file', '{}', start_dir }
  for _, line in ipairs(fd) do
    local path, typeinfo = line:match '^(.-):%s*(.+)$'
    if path and not path:match 'CMakeFiles' and typeinfo and typeinfo:match 'Mach%-O' or typeinfo:match 'ELF' then
      table.insert(results, path)
    end
  end
  return results
end

local function pick_executable(start_dir, on_choice)
  local executables = collect_executables(start_dir)
  if #executables == 0 then
    vim.notify('No executables found in ' .. start_dir, vim.log.levels.WARN)
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
          on_result(entry.value)
        end)
        map('i', '<Esc>', function(buf)
          actions.close(buf)
          on_result(nil)
        end)
        map('n', 'q', function(buf)
          actions.close(buf)
          on_result(nil)
        end)
        return true
      end,
    })
    :find()
end

local function pick_executable_for_dap(start_dir)
  return async.void(function()
    local co = coroutine.running()
    pick_executable(start_dir, function(choice)
      coroutine.resume(co, choice)
    end)
    local result = coroutine.yield()
    if not result then
      vim.notify('Debug launch cancelled', vim.log.levels.INFO)
    end
    return result
  end)()
end

return {
  pick_executable_for_dap = pick_executable_for_dap,
}
