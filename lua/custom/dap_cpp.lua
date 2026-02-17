local M = {}

local function has_configuration(configurations, name, adapter)
  for _, configuration in ipairs(configurations or {}) do
    if configuration.name == name and configuration.type == adapter then
      return true
    end
  end

  return false
end

function M.setup(dap)
  dap = dap or require 'dap'

  dap.adapters.codelldb = dap.adapters.codelldb or {
    type = 'executable',
    command = 'codelldb',
  }

  local launch_name = 'Launch current file (codelldb)'
  local launch_configuration = {
    name = launch_name,
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  }

  for _, language in ipairs { 'c', 'cpp' } do
    dap.configurations[language] = dap.configurations[language] or {}

    if not has_configuration(dap.configurations[language], launch_name, 'codelldb') then
      table.insert(dap.configurations[language], vim.deepcopy(launch_configuration))
    end
  end
end

return M
