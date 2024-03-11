return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    local dap, dapui = require 'dap', require 'dapui'

    -- Initialize dap-ui
    dapui.setup() -- This line is crucial for setting up dap-ui with its default configurations

    dap.listeners.before.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Configuration for .NET Core debugging
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'C:/Local_Files/netcoredbg/netcoredbg.exe',
      args = { '--interpreter=vscode' },
    }

    vim.g.dotnet_build_project = function()
      local default_path = vim.fn.getcwd() .. '/'
      if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
      end
      local path = vim.fn.input('Path to your *proj file', default_path, 'file')
      vim.g['dotnet_last_proj_path'] = path
      local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
      print ''
      print('Cmd to execute: ' .. cmd)
      local f = os.execute(cmd)
      if f == 0 then
        print '\nBuild: ✔️ '
      else
        print('\nBuild: ❌ (code: ' .. f .. ')')
      end
    end

    vim.g.dotnet_get_dll_path = function()
      local request = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end

      if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = request()
      else
        if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
          vim.g['dotnet_last_dll_path'] = request()
        end
      end

      return vim.g['dotnet_last_dll_path']
    end

    local config = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
            vim.g.dotnet_build_project()
          end
          return vim.g.dotnet_get_dll_path()
        end,
      },
    }

    dap.configurations.cs = config
    dap.configurations.fsharp = config

    local api = vim.api
    local keymap_restore = {}
    dap.listeners.after.event_initialized['restore_keymaps'] = function()
      for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
          if keymap.lhs == 'K' then
            table.insert(keymap_restore, keymap)
            api.nvim_buf_del_keymap(buf, 'n', 'K')
          end
        end
      end
      api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
    end

    dap.listeners.after.event_terminated['restore_keymaps'] = function()
      for _, keymap in ipairs(keymap_restore) do
        api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
      end
      keymap_restore = {}
    end

    -- Key mappings for dap
    vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = '[D]ebug [B]reakpoint' })
    vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
    vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = '[D]ebug step [I]nto' })
    vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = '[D]ebug step [O]ver' })
    vim.keymap.set('n', '<Leader>ds', dap.stop, { desc = '[D]ebug [S]top' })
  end,
}
