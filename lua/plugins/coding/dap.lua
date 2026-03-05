---@diagnostic disable: undefined-global
return {
  "mfussenegger/nvim-dap",
  keys = {
    { "<leader>pb", desc = "Toggle [B]reakpoint" },
    { "<leader>pc", desc = "[C]ontinue debugging" },
    { "<leader>pn", desc = "Step over ([N]ext)" },
    { "<leader>pi", desc = "Step [I]nto" },
    { "<leader>po", desc = "Step [O]ut" },
    { "<leader>pr", desc = "Open [R]EPL" },
    { "<leader>pl", desc = "Run [L]ast debug session" },
    { "<leader>px", desc = "Toggle debug UI" },
  },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Set up Go debugging
    require("dap-go").setup()

    -- Set up Python debugging
    dap.adapters.python = {
      type = 'executable',
      command = 'debugpy-adapter',
    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          if vim.env.VIRTUAL_ENV then
            return vim.env.VIRTUAL_ENV .. "/bin/python"
          end
          return '/usr/bin/python3'
        end,
      },
    }

    -- Set up C debugging with codelldb
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = 'codelldb',
        args = {"--port", "${port}"},
      },
    }

    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    -- Set up UI
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    -- Automatically open/close UI on session events
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Add keymaps
    vim.keymap.set('n', '<leader>pb', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>pc', dap.continue, { desc = 'Continue Debug' })
    vim.keymap.set('n', '<leader>pn', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<leader>pi', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<leader>po', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>pr', dap.repl.open, { desc = 'Debug REPL' })
    vim.keymap.set('n', '<leader>pl', dap.run_last, { desc = 'Run Last Debug' })
    vim.keymap.set('n', '<leader>px', dapui.toggle, { desc = 'Toggle Debug UI' })

    -- Profiling commands
    local function profile_go()
      local file = vim.fn.expand('%:p')
      local cmd = string.format('go test -cpuprofile cpu.prof -memprofile mem.prof -bench . %s', file)
      vim.fn.system(cmd)
      vim.cmd('split term://go tool pprof -http=:8080 cpu.prof')
    end

    local function profile_python()
      local file = vim.fn.expand('%:p')
      local cmd = string.format('py-spy record -o profile.svg -f speedscope -- python %s', file)
      vim.fn.system(cmd)
      vim.cmd('!xdg-open profile.svg')
    end

    local function profile_c()
      local file = vim.fn.expand('%:p:r')
      local cmd = string.format('perf record -g ./%s && perf report -g graph', file)
      vim.cmd('split term://' .. cmd)
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'go', 'python', 'c', 'cpp' },
      callback = function()
        local ft = vim.bo.filetype
        if ft == 'go' then
          vim.keymap.set('n', '<leader>mp', profile_go, { buffer = true, desc = 'Profile Go code' })
        elseif ft == 'python' then
          vim.keymap.set('n', '<leader>mp', profile_python, { buffer = true, desc = 'Profile Python code' })
        elseif ft == 'c' or ft == 'cpp' then
          vim.keymap.set('n', '<leader>mp', profile_c, { buffer = true, desc = 'Profile C/C++ code' })
        end
      end,
    })
  end,
}
