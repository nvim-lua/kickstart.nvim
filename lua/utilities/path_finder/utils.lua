-- Check to see if path is a part of the config.projects, if so set last_proj_path and last_dll_path
function M.GetProjConfig(path, config)
  local result = {}
  if config == nil then
    return result
  end
  local projects = config.projects

  if projects == nil then
    return result
  end
  for _, project in ipairs(projects) do
    if project.base_path and string.find(path, project.base_path) then
      -- TODO: nil check, if even needed.
      -- TODO: these names make no sense
      result.dotnet_last_proj_path = project.dotnet_proj_file
      result.dotnet_last_dll_path = project.dotnet_dll_path
      result.dotnet_debug_cwd = project.dotnet_debug_cwd
      result.project_found = true
      return result
    end
  end
  result.project_found = false
  return result
end

function M.search_up_path(project_root, path, pattern_func)
  local parent = vim.fn.fnamemodify(path, ':h')
  -- the parent of 'C:/' is 'C:/'
  if parent == path then
    return project_root
  end
  local parent_root = pattern_func(parent)
  -- returns nil when no root is found
  if parent_root == nil then
    return project_root
  end
  return M.search_up_path(parent_root, parent, pattern_func)
end

function M.dotnet_get_dll_path(path, proj_found)
  local request = function()
    return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
  end

  if path == nil then
    path = request()
    print('Dll path: ' .. path)
  else
    if proj_found == false and vim.fn.confirm('Do you want to change the path to dll?\n' .. path, '&yes\n&no', 2) == 1 then
      path = request()
      print('Dll path: ' .. path)
    end
  end

  return path
end

function M.dotnet_build_project(last_path, config)
  local default_path = vim.fn.getcwd() .. '/'
  if last_path ~= nil then
    default_path = last_path
  end
  local result = nil

  -- If project was found in config, use it
  if config.dotnet_last_proj_path ~= nil then
    print('Found project in config. Project file path is ' .. config.dotnet_last_proj_path)
    result = config.dotnet_last_proj_path
  else
    -- If the project was not found, always ask for it, but fill in the last path
    result = vim.fn.input('Path to your *proj file', default_path, 'file')
  end

  local cmd = 'dotnet build -c Debug ' .. result
  print ''
  print('Cmd to execute: ' .. cmd)
  -- TODO: This should be done in async way
  local f = os.execute(cmd)
  if f == 0 then
    print '\nBuild: ✔️ '
  else
    print('\nBuild: ❌ (code: ' .. f .. ')')
  end
  return result
end

return M
