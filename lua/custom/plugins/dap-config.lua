-- Custom DAP configuration for Python and Java
return {
  -- Main DAP plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      -- Basic debugging keymaps
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue",
      },
      {
        "<F1>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F2>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F3>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug: Set Conditional Breakpoint",
      },
      -- Additional keymaps
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Continue",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Debug: Toggle REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Debug: Run Last",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Terminate",
      },
    },
    config = function()
      local dap = require("dap")

      -- Mason DAP setup - auto-install debuggers
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = {
          "python",
          "javadbg",
          "javatest",
        },
        handlers = {},
      })

      -- Set up breakpoint icons
      local icons = vim.g.have_nerd_font
          and { Breakpoint = "", BreakpointCondition = "", BreakpointRejected = "", LogPoint = "", Stopped = "" }
        or { Breakpoint = "●", BreakpointCondition = "⊜", BreakpointRejected = "⊘", LogPoint = "◆", Stopped = "⭔" }

      for type, icon in pairs(icons) do
        local hl = (type == "Stopped") and "DapStop" or "DapBreak"
        vim.fn.sign_define("Dap" .. type, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },

  -- Python DAP support
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      -- Find python path - prefer virtual environment
      local python_path = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "python3"
        end
      end

      require("dap-python").setup(python_path())

      -- Add custom configurations
      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " +")
        end,
      })

      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "Django",
        program = vim.fn.getcwd() .. "/manage.py",
        args = { "runserver", "--noreload" },
      })
    end,
  },

  -- Java DAP support is handled by nvim-jdtls (see jdtls.lua)
  -- No separate configuration needed here

  -- Enhanced UI for debugging
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<F7>",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: Toggle UI",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: Toggle UI",
      },
    },
    config = function()
      local dapui = require("dapui")
      local dap = require("dap")

      -- Configure UI
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
        icons = vim.g.have_nerd_font and {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "▸",
        } or {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "*",
        },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}