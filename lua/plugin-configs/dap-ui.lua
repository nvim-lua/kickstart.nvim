return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'nvim-neotest/nvim-nio' },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },
  opts = {},
  config = function(_, opts)
    local dap = require 'dap'
    local mason_registry = require 'mason-registry'
    local codelldb = mason_registry.get_package 'codelldb'
    local ext_path = codelldb:get_install_path() .. '/extension/'
    local codelldb_path = ext_path .. 'adapter/codelldb'
    local liblldb_path = ext_path .. 'lldb/lib/liblldb.dylib'
    local dapui = require 'dapui'
    dapui.setup(opts)
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open {}
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close {}
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close {}
    end
    dap.adapters.lldb = {
      type = 'executable',
      command = codelldb_path, -- adjust as needed, must be absolute path
      name = 'lldb',
    }

    dap.adapters.cpp = {
      type = 'executable',
      attach = {
        pidProperty = 'pid',
        pidSelect = 'ask',
      },
      command = codelldb_path,
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = 'YES',
      },
      name = 'lldb',
    }

    dap.configurations.cpp = {
      {
        name = 'lldb',
        type = 'cpp',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/Binaries/App/App.exe', 'file')
        end,
        cwd = '${workspaceFolder}',
        externalTerminal = false,
        stopOnEntry = false,
        args = {},
      },
    }
  end,
}
