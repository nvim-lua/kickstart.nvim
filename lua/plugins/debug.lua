return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    --    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'dotnet/vscode-csharp',

    -- virtual Text
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    require('dapui').setup()
    require('dap-go').setup()
    require('nvim-dap-virtual-text').setup()
    require('lspconfig').omnisharp.setup {}
    require('dap.ext.vscode').load_launchjs(nil, {})
    local dap, dapui = require 'dap', require 'dapui'
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg',
      args = { '--interpreter=vscode' },
    }

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          --         return vim.fn.input('Path to dll:', '/Users/marctalcott/Documents/Projects/DotNetProjects/HelloWorld/bin/Debug/net8.0/', 'file')
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
        end,
        console = 'integratedTerminal',
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Keymaps for all
    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

    vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = '[d]ebug toggle [b]reakpoint' })

    --    vim.keymap.set('n', '<Leader>dB', dap.set_breakpoint(vim.fn.input 'Breakpoint condition: '), { desc = '[d]ebug conditional [B]reakpoint' })
    vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[d]ebug [c]continue' })
    vim.keymap.set('n', '<Leader>dC', dap.close, { desc = '[d]ebug [C]lose' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug Continue' })

    vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<F9>', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<F10>', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<F12>', dap.terminate, { desc = 'Terminate' })
    vim.keymap.set('n', '<Leader>dx', dap.terminate, { desc = 'Terminate' })
    vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = 'Step over' })
    vim.keymap.set('n', '<Leader>dr', dap.restart, { desc = 'Restart' })

    vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = '[d]ebug run [l]ast' })
    vim.api.nvim_set_keymap('n', '<leader>dR', ":lua require('dapui').open({reset = true})<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>ht', ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true })
    vim.keymap.set('n', '<Leader>?', function()
      dapui.eval(nil, { enter = true })
    end, { desc = 'Restart' })
  end,
}
