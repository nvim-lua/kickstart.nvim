-- Debug Adapters Configuration
local M = {}

-- Helper function to find Python executable
-- In Nix environments, use whatever Python is in PATH
local function get_python_path()
  -- Use the Python from current environment (Nix or system)
  if vim.fn.executable('python3') == 1 then
    return vim.fn.exepath('python3')
  elseif vim.fn.executable('python') == 1 then
    return vim.fn.exepath('python')
  else
    -- Fallback to system Python
    return '/usr/bin/python3'
  end
end

function M.setup()
  local dap = require('dap')
  
  -- Setup all language-specific adapters
  M.setup_python(dap)
  M.setup_cpp(dap)
  
  -- Add more adapters as needed
  -- M.setup_rust(dap)
  -- M.setup_go(dap)
  -- M.setup_javascript(dap)
end

-- Python debugger configuration
function M.setup_python(dap)
  dap.adapters.python = {
    type = 'executable',
    command = vim.fn.exepath('python3') ~= '' and vim.fn.exepath('python3') or 'python',
    args = { '-m', 'debugpy.adapter' },
  }
  
  dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      pythonPath = get_python_path,
    },
    {
      type = 'python',
      request = 'launch',
      name = 'Launch file with arguments',
      program = '${file}',
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, ' ')
      end,
      pythonPath = get_python_path,
    },
    {
      type = 'python',
      request = 'attach',
      name = 'Attach to running process',
      processId = require('dap.utils').pick_process,
      pythonPath = get_python_path,
    },
  }
end

-- C/C++/Rust debugger configuration (using lldb-dap)
function M.setup_cpp(dap)
  -- LLDB-DAP adapter (modern LLDB with DAP support)
  dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-dap', -- Will use lldb-dap from PATH (Nix environment)
    name = 'lldb',
  }
  
  -- C++ configuration
  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
    {
      name = 'Launch with arguments',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, ' ')
      end,
      runInTerminal = false,
    },
    {
      name = 'Attach to process',
      type = 'lldb',
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
    },
  }
  
  -- Share C++ configuration with C and Rust
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

-- Example: Go debugger configuration (commented out)
-- function M.setup_go(dap)
--   dap.adapters.delve = {
--     type = 'server',
--     port = '${port}',
--     executable = {
--       command = 'dlv',
--       args = { 'dap', '-l', '127.0.0.1:${port}' },
--     },
--   }
--   
--   dap.configurations.go = {
--     {
--       type = 'delve',
--       name = 'Debug',
--       request = 'launch',
--       program = '${file}',
--     },
--     {
--       type = 'delve',
--       name = 'Debug test',
--       request = 'launch',
--       mode = 'test',
--       program = '${file}',
--     },
--   }
-- end

return M