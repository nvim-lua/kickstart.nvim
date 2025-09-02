-- Telescope picker for selecting compile_commands.json
local M = {}

local function find_compile_commands()
  local root = vim.fn.getcwd()
  local cmd = string.format('find "%s" -name compile_commands.json -type f 2>/dev/null', root)
  local handle = io.popen(cmd)
  if not handle then
    return {}
  end
  
  local result = handle:read('*a')
  handle:close()
  
  local files = {}
  for line in result:gmatch('[^\n]+') do
    -- Get relative path for display
    local relative = line:gsub('^' .. vim.pesc(root) .. '/', '')
    table.insert(files, {
      path = line,
      display = relative,
      dir = vim.fn.fnamemodify(line, ':h'),
      relative_dir = vim.fn.fnamemodify(relative, ':h'),
    })
  end
  
  return files
end

function M.pick_compile_commands()
  local files = find_compile_commands()
  
  if #files == 0 then
    vim.notify('No compile_commands.json files found', vim.log.levels.WARN)
    return
  elseif #files == 1 then
    vim.notify('Using: ' .. files[1].display, vim.log.levels.INFO)
    M.set_compile_commands(files[1])
    return
  end
  
  -- Multiple files found, show picker
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  
  pickers.new({}, {
    prompt_title = 'Select compile_commands.json',
    finder = finders.new_table {
      results = files,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.display,
        }
      end,
    },
    sorter = conf.generic_sorter{},
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          M.set_compile_commands(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

function M.set_compile_commands(file_info)
  local clangd_config = string.format([[
CompileFlags:
  CompilationDatabase: %s
]], file_info.relative_dir)
  
  -- Write .clangd file
  local clangd_file = vim.fn.getcwd() .. '/.clangd'
  local file = io.open(clangd_file, 'w')
  if file then
    file:write(clangd_config)
    file:close()
    vim.notify('Created .clangd pointing to: ' .. file_info.relative_dir, vim.log.levels.INFO)
    
    -- Restart LSP if clangd is running
    local clients = vim.lsp.get_clients({ name = 'clangd' })
    if #clients > 0 then
      vim.notify('Restarting clangd...', vim.log.levels.INFO)
      -- Stop and start clangd to pick up new config
      for _, client in ipairs(clients) do
        client.stop()
      end
      vim.defer_fn(function()
        vim.cmd('LspStart clangd')
        vim.notify('Clangd restarted with new configuration', vim.log.levels.INFO)
      end, 100)
    end
  else
    vim.notify('Failed to create .clangd file', vim.log.levels.ERROR)
  end
end

-- Auto-detect multiple compile_commands.json on startup
function M.auto_detect()
  local files = find_compile_commands()
  
  if #files > 1 then
    -- Check if .clangd already exists
    local clangd_file = vim.fn.getcwd() .. '/.clangd'
    if vim.fn.filereadable(clangd_file) == 0 then
      vim.notify(
        string.format('Found %d compile_commands.json files. Use :CompileCommandsPicker to select one.', #files),
        vim.log.levels.INFO
      )
    end
  end
end

-- Setup function to create command
function M.setup()
  vim.api.nvim_create_user_command('CompileCommandsPicker', function()
    M.pick_compile_commands()
  end, { desc = 'Select compile_commands.json for clangd' })
  
  -- Auto-detect on entering a C/C++ file
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'objc', 'objcpp' },
    callback = function()
      -- Only run once per session
      if not vim.g.compile_commands_detected then
        vim.g.compile_commands_detected = true
        vim.defer_fn(function()
          M.auto_detect()
        end, 100)
      end
    end,
  })
end

return M