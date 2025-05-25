return {
  pick_executable = function()
    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'
    local conf = require('telescope.config').values

    local entry_maker = function(entry)
      return {
        value = entry,
        display = entry,
        ordinal = entry,
      }
    end

    local co = coroutine.running()
    pickers
      .new({}, {
        prompt_title = 'Select binary',
        finder = finders.new_oneshot_job {
          'fd',
          '--type',
          'f',
          '--exec-batch',
          'test',
          '-x',
          '{}',
          ';',
          'echo',
          '{}',
          '',
          'build/',
        },
        sorter = conf.generic_sorter {},
        attach_mappings = function(_, map)
          map('i', '<CR>', function(bufnr)
            local entry = require('telescope.actions.state').get_selected_entry()
            require('telescope.actions').close(bufnr)
            coroutine.resume(co, entry.value)
          end)
          return true
        end,
      })
      :find()
    return coroutine.yield()
  end,
}
