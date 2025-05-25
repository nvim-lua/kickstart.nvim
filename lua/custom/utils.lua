local function is_executable(path)
  -- Use `file` command to identify Mach-O or ELF binaries
  local output = vim.fn.system { 'file', '-b', path }
  return output:match 'Mach%-O' or output:match 'ELF'
end

local function collect_executables(dir)
  local files = vim.fn.globpath(dir, '**', true, true)
  local binaries = {}
  for _, path in ipairs(files) do
    if vim.fn.filereadable(path) == 1 and is_executable(path) then
      table.insert(binaries, path)
    end
  end
  return binaries
end

local function pick_executable(start_dir)
  local co = coroutine.running()
  if not co then
    error 'pick_executable must be called from a coroutine'
  end

  local executables = collect_executables(start_dir)
  if #executables == 0 then
    vim.notify('No executables found in ' .. start_dir, vim.log.levels.WARN)
    return
  end

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Select Executable',
      finder = require('telescope.finders').new_table {
        results = executables,
      },
      sorter = require('telescope.config').values.generic_sorter {},
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local entry = require('telescope.actions.state').get_selected_entry()
          require('telescope.actions').close(prompt_bufnr)
          coroutine.resume(co, entry.value)
        end)
        return true
      end,
    })
    :find()

  return coroutine.yield()
end

return {
  pick_executable = pick_executable,
}
