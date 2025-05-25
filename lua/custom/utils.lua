return {
  pick_executable = function(start_dir)
    local scan = require 'plenary.scandir'
    local Path = require 'plenary.path'
    local results = {}

    -- Recursively scan for files
    scan.scan_dir(start_dir, {
      hidden = true,
      depth = 3,
      add_dirs = false,
      on_insert = function(file)
        local file_type = vim.fn.system { 'file', '-b', file }
        if file_type:match 'Mach%-O' or file_type:match 'ELF' then
          table.insert(results, file)
        end
      end,
    })

    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'
    local conf = require('telescope.config').values
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    return coroutine.create(function(coro)
      pickers
        .new({}, {
          prompt_title = 'Select Executable',
          finder = finders.new_table {
            results = results,
          },
          sorter = conf.generic_sorter {},
          attach_mappings = function(_, map)
            actions.select_default:replace(function(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              coroutine.resume(coro, selection[1])
            end)
            return true
          end,
        })
        :find()
    end)
  end,
}
