local mason_dap = require 'mason-nvim-dap'
local dap = require 'dap'
local ui = require 'dapui'
local dap_virtual_text = require 'nvim-dap-virtual-text'

-- Dap Virtual Text
dap_virtual_text.setup()

mason_dap.setup {
  ensure_installed = { 'cppdbg', 'debugpy' },
  automatic_installation = true,
  handlers = {
    function(config)
      require('mason-nvim-dap').default_setup(config)
    end,
  },
}
-- Configurations
dap.configurations = {
  c = {
    {
      name = 'Launch file',
      type = 'cppdbg',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = false,
      MIMode = 'lldb',
    },
    {
      name = 'Attach to lldbserver :1234',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'lldb',
      miDebuggerServerAddress = 'localhost:1234',
      miDebuggerPath = '/usr/bin/lldb',
      cwd = '${workspaceFolder}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  },
  python = {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return '/usr/bin/python3'
    end,
  },
}

-- Dap UI

ui.setup()

vim.fn.sign_define('DapBreakpoint', { text = '🐞' })

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end
